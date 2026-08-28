# Gloss localization source

Extracted from the Flutter app and the Play country list
(`Gloss-images/all-countries`).

## Feasibility

- Play countries in the list: **177**
- Unique locale ids: **68**
- Unique translation files: **60** (`af`, `ar`, `az`, `be`, `bg`, `bn`, `cs`, `da`, `de`, `el`, `en`, `es`, `es_419`, `et`, `fi`, `fil`, `fr`, `fr_CA`, `he`, `hi`, `hr`, `hu`, `hy`, `id`, `is`, `it`, `ja`, `ka`, `kk`, `km`, `ko`, `ky`, `lo`, `lt`, `lv`, `mk`, `ms`, `my`, `nb`, `ne`, `nl`, `pl`, `pt`, `pt_BR`, `ro`, `ru`, `si`, `sk`, `sl`, `sq`, `sr`, `sv`, `sw`, `th`, `tr`, `uk`, `ur`, `vi`, `zh_HK`, `zh_TW`)
- Unique language names: **57**

The English headword (lemma), pronunciation, etymon, and root *forms* stay
English / source-language. UI chrome and explanations are translated.

## Do not translate

- `Gloss`
- `Beautiful Words`
- Word lemmas (`word`, `variants`)
- `pronunciation`
- `originWord`
- Root `form` strings

## UI chrome

| Key | English |
| --- | --- |
| `appTitle` *(keep)* | Gloss |
| `tagline` | a lexicon of lovely language |
| `navHome` | Home |
| `navLexicon` | Lexicon |
| `navQuiz` | Quiz |
| `navSaved` | Saved |
| `navLanguages` | Languages |
| `homeBlurb` | {count} rare, rich words from the {lexicon} lexicon — explained the way a friend would explain them, not a dictionary. |
| `wordsExplored` | {current} of {total} words explored |
| `exploreLexicon` | Explore the lexicon |
| `startQuiz` | Start a quiz |
| `wordOfTheDay` | word of the day |
| `readFullEntry` | Read the full entry → |
| `lexiconTitle` | The lexicon |
| `lexiconCaption` | the gathering |
| `savedTitle` | Saved words |
| `savedCaption` | kept close |
| `searchHint` | Search a word, or describe its meaning… |
| `clearSearch` | Clear search |
| `filterAll` | All |
| `noMatches` | No matches yet — try a different word or feeling. |
| `matchCount` | {n, plural, =1{1 match} other{{n} matches}} |
| `nothingHere` | nothing here |
| `emptyLexicon` | Nothing in this corner of the lexicon. |
| `emptySaved` | No saved words yet. Tap the heart on any entry. |
| `tapToReadMore` | Tap to read more |
| `saveWord` | Save word |
| `removeFromFavorites` | Remove from favorites |
| `inPlainWords` | in plain words |
| `theDefinition` | the definition |
| `inASentence` | in a sentence |
| `exampleGlossLabel` | in other words |
| `save` | Save |
| `saved` | Saved |
| `copy` | Copy |
| `copiedToClipboard` | Copied to clipboard |
| `roots` | roots |
| `quizTitle` | A little quiz |
| `quizCaption` | know the roots, then choose the meaning |
| `quizIntro` | Each question shows a word and its etymology. Pick the definition that fits — four choices, one true. |
| `howManyWords` | how many words |
| `begin` | Begin |
| `quizByTheme` | Quiz by theme |
| `endQuiz` | End quiz |
| `questionOf` | Question {index} of {length} |
| `whichDefinitionFits` | which definition fits? |
| `previous` | Previous |
| `next` | Next |
| `seeResults` | See results |
| `themeTitle` | Theme |
| `chooseASubject` | choose a subject |
| `noThemesYet` | No themes yet. |
| `notEnoughWordsInTheme` | Not enough words in this theme yet. |
| `results` | Results |
| `perfectPage` | a perfect page |
| `wellMarked` | well marked |
| `tryAnotherRound` | Try another round |
| `definitionsRight` | {score, plural, =1{1 definition right} other{{score} definitions right}} |
| `definitionsRightSpoken` | {score, plural, =1{One definition right, of {total}.} other{{score} definitions right, of {total}.}} |
| `switchToLightMode` | Switch to light mode |
| `switchToDarkMode` | Switch to dark mode |
| `listen` | Listen |
| `stop` | Stop |
| `glossIcon` *(keep)* | Gloss icon |
| `languagesTitle` | Languages |
| `languagesCaption` | the tongues |
| `searchLanguages` | Search a country or language… |
| `noMatchingLanguages` | No matching countries or languages. |
| `selectedLanguage` | Reading in |
| `continentAfrica` | Africa |
| `continentAsia` | Asia |
| `continentEurope` | Europe |
| `continentAmericas` | Americas |
| `continentOceania` | Oceania |
| `currentOfTotal` | {current} of {total} |
| `speechAlso` | Also {variants}. |
| `speechAsIn` | As in: {example} |
| `speechFrom` | From {origin}, {originWord}. |
| `speechRoot` | {form}, meaning {meaning} |
| `speechInPlainWords` | In plain words: {friendly} |
| `categorySpeech` | Speech & Rhetoric |
| `categoryCharacter` | Character & Temperament |
| `categoryCriticism` | Criticism & Insult |
| `categoryVirtue` | Virtue |
| `categoryVice` | Vice |
| `categoryKnowledge` | Knowledge & Thought |
| `categoryReligion` | Religion & Spirit |
| `categoryBeginnings` | Beginnings |
| `categoryConflict` | Conflict & Deceit |
| `categoryAppearance` | Appearance & Light |
| `categoryPeople` | People & Roles |
| `categoryObjects` | Objects & Things |
| `categoryEmotion` | Emotion |
| `categoryArchaic` | Old & Archaic |

## Sample word (Edulcorate)

**Keep**

- word: `Edulcorate`
- pronunciation: `ee-DUL-cor-ate`
- originWord: `edulcorare`
- root forms: `e-, ex-`, `dulcis`

**Translate**

- partOfSpeech: verb
- definition: To sweeten or purify; to remove harshness from something.
- friendly: To take the sting or bitterness out of something — literally sweetening it, or figuratively softening a harsh idea so it goes down easier.
- example (keep English sentence, add a gloss): The editor edulcorated the harsh review before it went to print.
- origin: Latin
- root meanings: out, thoroughly; sweet

## Files

- `l10n/catalog.json` — countries, flags, continents, locales
- `l10n/source/ui.json` — UI strings for the translation script
- `l10n/source/content.json` — 134 word explanation fields
