<div align="center">

# Gloss

### A Flutter lexicon of lovely language — explore rare words, study their etymology, and quiz yourself.

Companion to **Beautiful Words**: [beautiful-words.vercel.app](https://beautiful-words.vercel.app/) · [github.com/raimonvibe/beautiful-words](https://github.com/raimonvibe/beautiful-words)

The home-screen name is **Gloss** (short enough for a phone icon). The store listing can read **Gloss: Beautiful Words**.

</div>

---

## What this is

A mobile reading of the Beautiful Words lexicon: 134 rare English words with plain-language explanations, etymology cards, and a four-choice definition quiz. The look follows the web app’s hand-bound-book palette — parchment gradients, gold-to-wine frames, Playfair Display headings, Cormorant Garamond body, Tangerine script.

## Features

- **Etymology card** — word, pronunciation, language of origin, and a root-by-root breakdown
- **Multiple-choice quiz** — four definitions, gold/wine feedback, previous/next navigation
- **Progress tracker** — quiz position and how much of the lexicon you’ve opened
- **Theme toggle** — light, dark, or system, remembered between launches
- **Lexicon + search** — the full Beautiful Words list, category chips, favorites
- **Word of the Day** — same date-based pick as the website

## Getting started

**Prerequisites:** [Flutter](https://docs.flutter.dev/get-started/install) 3.27+ (Dart 3.6+).

```bash
flutter create . --org com.raimonvibe --project-name beautiful_words --platforms android,ios,web,linux
```

Then set the launcher label to **Gloss** (so it is not overwritten by the package name):

- **Android** — `android:label="Gloss"` on the `<application>` in `android/app/src/main/AndroidManifest.xml`
- **iOS** — `CFBundleDisplayName` = `Gloss` in `ios/Runner/Info.plist`

```bash
flutter pub get
dart run flutter_launcher_icons
flutter run
flutter test
```

`flutter create .` only adds the platform folders (`android/`, `ios/`, `web/`, `linux/`). It will not overwrite `lib/`.

## Design tokens

Lifted from the web app’s `app/globals.css`:

| Token | Light | Dark |
| --- | --- | --- |
| Page | cream parchment `#fbf4e4 → #f0ddb8` | navy-plum `#16111d → #241a2c` |
| Gold | `#a9762f` | `#e0b45c` |
| Wine | `#7a2e3a` | `#d98a97` |
| Card | `#fffdf7` | `#241a2c` |

## Project layout

```
lib/
  main.dart                 # SharedPreferences, word load, runApp
  app.dart                  # Theme + bottom navigation shell
  branding.dart             # Gloss display name
  theme/                    # Palette and typography
  models/word_entry.dart
  data/                     # Lexicon loader, search, quiz engine
  state/                    # Theme, favorites, explored, quiz session
  screens/                  # Home, lexicon, detail, quiz, results
  widgets/                  # Etymology card, choices, progress, toggle
assets/data/words.json      # 134 words + etymology
```

Word data is adapted from `lib/words.ts` in the website repo, with origin language and root components added for the etymology card. To refresh the list from a newer website checkout, edit `tool/merge_etymology.js` and run `node tool/merge_etymology.js`.

## License

MIT — see [`LICENSE`](./LICENSE).
