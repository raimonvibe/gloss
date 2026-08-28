# Gloss — Google Play Console, step by step

This is a beginner walkthrough for publishing **Gloss** (`com.raimonvibe.beautiful_words`).
Each step starts with **Where** — click those items in the **left menu** of Play Console after you open the app.

Open Play Console: [https://play.google.com/console](https://play.google.com/console)

Sign in with the Google account that owns the RaimonVibe developer account.

---

## Before you click anything

Do these three things first. Play will refuse the listing if they are missing.

1. **Privacy page must open in a browser** (not only exist on GitHub).  
   Open: [https://raimonvibe.eu/apps/gloss/privacy](https://raimonvibe.eu/apps/gloss/privacy)  
   If you see an error, wait until the editorial website finishes deploying, then come back.

2. **Signed app bundle** is already built on this computer:  
   `build/app/outputs/bundle/release/app-release.aab`  
   (That file is not in git. Rebuild with `flutter build appbundle --release` if it is gone.)

3. **Graphics** — use these files:

| What Play asks for | File |
| --- | --- |
| High-res icon 512×512 | `C:\Users\rober\Pictures\Gloss-images\play-icon-512.png` |
| Feature graphic 1024×500 | `store/play/graphics/feature-graphic-1024x500.png` (this repo) |
| Phone screenshots (8) | `C:\Users\rober\Pictures\Gloss-images\play-phone-screenshots\` |

Upload screenshots **in number order**: `01` then `02` … through `08`.

---

## Step 1 — Create the app (first time only)

**Where:** Home (top of the left menu) → **Create app**

1. Default language: **English (United States)**.
2. App name: `Gloss: Beautiful Words` (30 characters max).
3. This is an **app**, not a game.
4. It is **Free**.
5. Contact email: `info@raimonvibe.com`.
6. Tick the boxes for Developer Program Policies, US export laws, and Play App Signing.
7. Click **Create app**.

You now have an empty app. The left menu is for *this* app. Stay inside it for every later step.

The package name is locked the first time you upload the `.aab`. Ours is already **`com.raimonvibe.beautiful_words`**. Do not create a second app with a different id.

---

## Step 2 — Dashboard checklist

**Where:** **Dashboard** (left menu, near the top)

Play shows a “Set up your app” list. Work through it in the order below. Grey ticks turn green as you save each form.

If this Google account was created as a **personal developer account after 13 November 2023**, you cannot go straight to Production. You must run a **closed test** first (Step 10). Organisation accounts and older personal accounts may skip that wait.

---

## Step 3 — Store listing text and pictures

**Where:** **Grow users** → **Store presence** → **Main store listing**

Scroll to **App details** and paste:

**App name**

```
Gloss: Beautiful Words
```

**Short description** (80 characters max)

```
A lexicon of lovely language: rare words, etymology, and a friendly quiz.
```

**Full description** (4000 characters max)

```
Gloss is a small, cozy lexicon of rare and often-forgotten English words — explained the way a friend would explain them, not a dictionary.

Open the Beautiful Words lexicon and you will find 134 rich entries. Each one pairs a traditional definition with a warm, plain-English explanation, a pronunciation, an example, and the word’s roots. Search by the word itself, or describe the meaning you are looking for.

Features
• Word of the day — a new featured word every day
• Lexicon — browse, search, and filter by theme
• Etymology — see the roots, not just the gloss
• Read aloud — hear the word and its meaning
• A little quiz — a word, its roots, four meanings, one true
• Saved words — keep the ones that stay with you
• Light and dark reading — parchment by day, lamplight by night

The look is a well-loved book: cream parchment, gold flourishes, and quiet serif type. No accounts, no ads, no feed. Just words worth keeping.
```

Then scroll to **Graphics**:

1. **App icon** — upload `play-icon-512.png`. Must be 512×512 PNG.
2. **Feature graphic** — upload `store/play/graphics/feature-graphic-1024x500.png`. Must be exactly 1024×500. No transparent pixels.
3. **Phone screenshots** — at least 2, we have 8. Drag them in order 01–08. Do **not** upload the files whose names end in `removebg`.
4. Skip tablet, TV, Wear, and Chromebook screenshots. Skip the preview video for now.

Click **Save**.

Do not put “Best”, “#1”, “Download now”, or emoji in the title.

---

## Step 4 — Category, tags, and contact

**Where:** **Grow users** → **Store presence** → **Store settings**

1. **App category:** **Education** (or **Books & Reference** if you prefer). Not a game.
2. Tags: pick a few that fit, for example language learning / education. Do not stuff keywords.
3. Scroll to **Contact details**:
   - Email (required): `info@raimonvibe.com`
   - Website: `https://raimonvibe.eu/apps/gloss`
4. Save.

---

## Step 5 — Privacy policy (required)

**Where:** **Policy and programs** → **App content**  
(On some accounts the group is labelled **Monitor and improve** → **Policy and programs** → **App content**.)

1. Find the **Privacy policy** card.
2. Click **Start** (or **Manage** if you already started).
3. Paste this URL, then save:

```
https://raimonvibe.eu/apps/gloss/privacy
```

Open that link in a new tab first. If it 404s, Play will reject the listing.

---

## Step 6 — Ads declaration

**Where:** **Policy and programs** → **App content** → **Ads** → **Start**

Answer **No**. Gloss has no ads and no ad SDK.

Save.

---

## Step 7 — Content rating

**Where:** **Policy and programs** → **App content** → **Content ratings** → **Start**

1. Email: `info@raimonvibe.com`.
2. Category: **Utility, Productivity, Communication, or Other** (this is a lexicon / education app, not a game).
3. Answer the IARC questions honestly. For Gloss:
   - No violence, no sex, no drugs, no gambling, no user-to-user chat, no location sharing, no user-generated public posts.
   - Mild language in some dictionary-style definitions is possible — if a question asks about “adult humour” or “profanity”, pick the mildest option that is still true.
4. Submit the questionnaire. Play emails a rating. Come back to this card and **Apply certificate** if it asks you to.

Unrated apps can be removed from Play. Do not skip this.

---

## Step 8 — Target audience

**Where:** **Policy and programs** → **App content** → **Target audience and content** → **Start**

Gloss is a vocabulary app for adults and older students, not a children’s game.

Recommended answers:

1. **Target age group:** **18 and up** only (do **not** tick under-13 groups).  
   Ticking children would force Families policy, a privacy policy *inside* the app, and extra review.
2. News app? **No**.
3. Appeal to children? **No**. The listing uses a literary icon, not cartoon characters.

Save each page of the wizard.

---

## Step 9 — Data safety

**Where:** **Policy and programs** → **App content** → **Data safety** → **Start**

Play wants to know if data **leaves the device**. Saved words and theme stay in local storage. That is **not** “collection” on this form.

Walk through the overview, then:

| Question | Answer for Gloss |
| --- | --- |
| Does your app collect or share any of the required user data types? | **No** |
| Is all of the user data collected encrypted in transit? | Skip — nothing is sent |
| Do you provide a way for users to request that their data is deleted? | Skip — uninstalling removes local data |

**Security practices** (if still shown after “No”):

- Independent security review? **No**.
- Committed to Play Families Policy? **No** (we did not target children).

Preview the store listing card. It should say the app does not collect user data. Submit.

**Read aloud:** the phone’s own speech engine may talk. That is Android, not our server. Do not list it as data we collect.

**Google Fonts:** display fonts *may* load from Google when the device is online. The privacy policy already mentions this. If Play later asks about “App activity” or identifiers from a font request, keep the form matching what a release build actually does. Debug builds request `INTERNET`; the main release manifest does not.

---

## Step 10 — Other App content cards

Stay on **Policy and programs** → **App content**. Finish every card that still says **Needs attention**.

| Card | What to choose |
| --- | --- |
| **News apps** | **No** |
| **COVID-19 contact tracing and status apps** | None of those features |
| **Government apps** | **No** |
| **Financial features** | **No** |
| **Health** | **No** |
| **Sign-in details** | All of the app is usable without a login. You can skip extra reviewer accounts. |
| **App access** | Same — no locked sections. |
| **Ads** | Already **No** in Step 6. |
| **Data safety** | Already Step 9. |
| **Privacy policy** | Already Step 5. |

Save each one. The Dashboard ticks should go green.

---

## Step 11 — Countries / pricing

**Where:** **Monetize with Play** → **Products** → **App pricing**  
(or **Test and release** → **Production** → **Countries/regions** — Play moves this sometimes)

1. Confirm the app is **Free**.
2. Add countries. For a first launch, **Add all countries** is simplest.
3. Save.

VAT / merchant profile is only needed for paid apps or in-app products. Gloss has none.

---

## Step 12 — Upload the signed bundle

**Where (first upload, most accounts):** **Test and release** → **Testing** → **Closed testing** → **Create new release**

If Play lets you use Production immediately:

**Where:** **Test and release** → **Production** → **Create new release**

1. First time: accept **Play App Signing**. Let Google manage the app signing key. Your file is already signed with the **upload** key in `Documents/Keys-beautiful-words`. Do not lose that folder.
2. Drag `app-release.aab` onto **App bundles**.
3. Release name: `1.0.0` (or leave the default version name).
4. Release notes:

```
<en-US>
First release of Gloss — a lexicon of lovely language.
134 rare words, etymology, read aloud, and a little quiz.
</en-US>
```

5. **Next** → **Save** → **Start rollout to closed testing** (or Production, only if you are allowed).

**Closed testing extras** (personal accounts after Nov 2023):

**Where:** **Test and release** → **Testing** → **Closed testing** → **Testers** tab

- Create an email list of at least **12** testers.
- They must **opt in** with the link Play gives you and **stay opted in for 14 days in a row**.
- Add a feedback email: `info@raimonvibe.com`.

**Where:** same page → **Countries/regions** tab — add the countries testers live in.

When 12 testers have been opted in for 14 days:

**Where:** **Dashboard** → **Apply for production access** (button appears when Play thinks you are ready).

Answer the questionnaire truthfully (what you tested, that the app works, that testers used it). Then create a **Production** release with the same `.aab` (or a newer one with a higher `versionCode`).

---

## Step 13 — Send for review

**Where:** **Publishing overview** (left menu, under **Test and release** or **Publishing**)

If **Managed publishing** is on, changes sit until you click **Send for review** / **Publish**. If it is off, saving a rollout often sends the review automatically.

Wait. First reviews often take a few days. Play emails the account.

---

## If something is rejected

**Where:** **Policy and programs** → **Policy status**  
and **Publishing overview**

Read the exact reason. Fix only that. Common Gloss mistakes:

- Privacy URL not live.
- Feature graphic not 1024×500.
- Screenshots still have a transparent background (`removebg` files).
- Data safety says you collect data when you do not (or the reverse).
- Target audience includes children by accident.

Then send for review again. Do not create a second app with a new package name.

---

## Files on this computer (cheat sheet)

| Item | Path |
| --- | --- |
| This guide | `store/play/GOOGLE-PLAY-CONSOLE.md` |
| Feature graphic | `store/play/graphics/feature-graphic-1024x500.png` |
| Icon | `C:\Users\rober\Pictures\Gloss-images\play-icon-512.png` |
| Screenshots | `C:\Users\rober\Pictures\Gloss-images\play-phone-screenshots\` |
| Listing copy | `C:\Users\rober\Pictures\Gloss-images\play-store-listing.txt` |
| Signed bundle | `build/app/outputs/bundle/release/app-release.aab` |
| Upload key (never git) | `C:\Users\rober\Documents\Keys-beautiful-words\` |
| Privacy source | [github.com/raimonvibe/website-editorial-eu](https://github.com/raimonvibe/website-editorial-eu) — live URL `/apps/gloss/privacy` |

Official help: [Create an app](https://support.google.com/googleplay/android-developer/answer/9859152), [Store listing graphics](https://support.google.com/googleplay/android-developer/answer/9866151), [App content / privacy](https://support.google.com/googleplay/android-developer/answer/9859455), [Data safety](https://support.google.com/googleplay/android-developer/answer/10787469), [Closed testing for new personal accounts](https://support.google.com/googleplay/android-developer/answer/14151465).
