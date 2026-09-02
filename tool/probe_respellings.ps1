# Which respelling syllables does a speech engine spell out instead of saying?
#
# A syllable is not a word, and an engine given one guesses from spelling. Some
# guesses are letter names: `ih` comes out "eye-aitch", `uk` comes out "U.K.".
# Nothing in a widget test can see this, and no rule about the spelling predicts
# it, so the only honest way to know is to ask an engine.
#
# This asks Windows SAPI, which reports the phonemes it is about to speak. Each
# token is spoken twice - as itself, and as its own letters spaced apart - in a
# carrier phrase, because a token alone at the end of an utterance is treated as
# an abbreviation where the same token inside a phrase is not. If the two
# readings share a phoneme sequence, the engine is spelling the token.
#
#   powershell -NoProfile -File tool/probe_respellings.ps1
#
# Reads  tool/respelling_tokens.txt  (one token per line)
# Writes tool/respelling_probe.json  (the verdict per token)
#
# SAPI is not the engine on the reader's phone - Google's Android engine spells
# a different, overlapping set, which is why `py` was reported wrong from a
# device while SAPI says it correctly. Treat a "spelled" verdict as proof and a
# "said" verdict as no more than the absence of one, and prefer a replacement
# that is an ordinary English word, which no engine has to guess at.

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Speech

$root   = Split-Path -Parent $PSScriptRoot
$inFile = Join-Path $root 'tool\respelling_tokens.txt'
$out    = Join-Path $root 'tool\respelling_probe.json'
$wav    = Join-Path $env:TEMP 'respelling_probe.wav'

function Get-Phonemes([string]$text) {
  $bag = New-Object System.Collections.ArrayList
  $s = New-Object System.Speech.Synthesis.SpeechSynthesizer
  $s.SetOutputToWaveFile($wav)
  $s.Rate = 4
  $ev = Register-ObjectEvent -InputObject $s -EventName PhonemeReached -MessageData $bag `
        -Action { $Event.MessageData.Add($EventArgs.Phoneme) | Out-Null }
  $s.Speak($text)
  Start-Sleep -Milliseconds 130
  Unregister-Event -SourceIdentifier $ev.Name
  $s.Dispose()
  $seq = @()
  foreach ($p in $bag) { $seq += (($p.ToCharArray() | ForEach-Object { [int]$_ }) -join '.') }
  # Sorted, because PhonemeReached is delivered on the event queue and the order
  # jitters against the carrier from one run to the next while the phonemes
  # themselves do not. Comparing the sequence made the verdicts differ by a
  # dozen tokens between two runs of this script; comparing the multiset is
  # stable over repeated runs.
  return (($seq | Sort-Object) -join ' ')
}

$voice = (New-Object System.Speech.Synthesis.SpeechSynthesizer).Voice.Name
$tokens = Get-Content $inFile | Where-Object { $_.Trim() -ne '' -and -not $_.StartsWith('#') }
$said = @(); $spelled = @()
foreach ($t in $tokens) {
  $t = $t.Trim()
  $asWord    = Get-Phonemes ("duh {0} duh" -f $t)
  $asLetters = Get-Phonemes ("duh {0} duh" -f ($t.ToCharArray() -join ' '))
  if ($asWord -eq $asLetters -and $t.Length -gt 1) { $spelled += $t } else { $said += $t }
  Write-Host ("{0,-8} {1}" -f $t, $(if ($asWord -eq $asLetters -and $t.Length -gt 1) { 'SPELLED' } else { 'said' }))
}

[pscustomobject]@{
  voice     = $voice
  carrier   = 'duh <token> duh'
  generated = (Get-Date -Format 'yyyy-MM-dd')
  said      = $said
  spelled   = $spelled
} | ConvertTo-Json | Out-File -FilePath $out -Encoding utf8
Write-Host ("`n{0} tokens: {1} said, {2} spelled -> {3}" -f $tokens.Count, $said.Count, $spelled.Count, $out)
