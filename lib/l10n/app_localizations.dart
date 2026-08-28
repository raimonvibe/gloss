import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_af.dart';
import 'app_localizations_ar.dart';
import 'app_localizations_az.dart';
import 'app_localizations_be.dart';
import 'app_localizations_bg.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_et.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fil.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_he.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_hr.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_hy.dart';
import 'app_localizations_id.dart';
import 'app_localizations_is.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ka.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_km.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ky.dart';
import 'app_localizations_lo.dart';
import 'app_localizations_lt.dart';
import 'app_localizations_lv.dart';
import 'app_localizations_mk.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_my.dart';
import 'app_localizations_nb.dart';
import 'app_localizations_ne.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_si.dart';
import 'app_localizations_sk.dart';
import 'app_localizations_sl.dart';
import 'app_localizations_sq.dart';
import 'app_localizations_sr.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_sw.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('af'),
    Locale('ar'),
    Locale('az'),
    Locale('be'),
    Locale('bg'),
    Locale('bn'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('es', '419'),
    Locale('et'),
    Locale('fi'),
    Locale('fil'),
    Locale('fr'),
    Locale('fr', 'CA'),
    Locale('he'),
    Locale('hi'),
    Locale('hr'),
    Locale('hu'),
    Locale('hy'),
    Locale('id'),
    Locale('is'),
    Locale('it'),
    Locale('ja'),
    Locale('ka'),
    Locale('kk'),
    Locale('km'),
    Locale('ko'),
    Locale('ky'),
    Locale('lo'),
    Locale('lt'),
    Locale('lv'),
    Locale('mk'),
    Locale('ms'),
    Locale('my'),
    Locale('nb'),
    Locale('ne'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('ro'),
    Locale('ru'),
    Locale('si'),
    Locale('sk'),
    Locale('sl'),
    Locale('sq'),
    Locale('sr'),
    Locale('sv'),
    Locale('sw'),
    Locale('th'),
    Locale('tr'),
    Locale('uk'),
    Locale('ur'),
    Locale('vi'),
    Locale('zh'),
    Locale('zh', 'HK'),
    Locale('zh', 'TW')
  ];

  /// Do not translate. Brand name.
  ///
  /// In en, this message translates to:
  /// **'Gloss'**
  String get appTitle;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'a lexicon of lovely language'**
  String get tagline;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navLexicon.
  ///
  /// In en, this message translates to:
  /// **'Lexicon'**
  String get navLexicon;

  /// No description provided for @navQuiz.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get navQuiz;

  /// No description provided for @navSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get navSaved;

  /// No description provided for @navLanguages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get navLanguages;

  /// No description provided for @homeBlurb.
  ///
  /// In en, this message translates to:
  /// **'{count} rare, rich words from the {lexicon} lexicon — explained the way a friend would explain them, not a dictionary.'**
  String homeBlurb(int count, String lexicon);

  /// No description provided for @wordsExplored.
  ///
  /// In en, this message translates to:
  /// **'{current} of {total} words explored'**
  String wordsExplored(int current, int total);

  /// No description provided for @exploreLexicon.
  ///
  /// In en, this message translates to:
  /// **'Explore the lexicon'**
  String get exploreLexicon;

  /// No description provided for @startQuiz.
  ///
  /// In en, this message translates to:
  /// **'Start a quiz'**
  String get startQuiz;

  /// No description provided for @wordOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'word of the day'**
  String get wordOfTheDay;

  /// No description provided for @readFullEntry.
  ///
  /// In en, this message translates to:
  /// **'Read the full entry →'**
  String get readFullEntry;

  /// No description provided for @lexiconTitle.
  ///
  /// In en, this message translates to:
  /// **'The lexicon'**
  String get lexiconTitle;

  /// No description provided for @lexiconCaption.
  ///
  /// In en, this message translates to:
  /// **'the gathering'**
  String get lexiconCaption;

  /// No description provided for @savedTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved words'**
  String get savedTitle;

  /// No description provided for @savedCaption.
  ///
  /// In en, this message translates to:
  /// **'kept close'**
  String get savedCaption;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search a word, or describe its meaning…'**
  String get searchHint;

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @noMatches.
  ///
  /// In en, this message translates to:
  /// **'No matches yet — try a different word or feeling.'**
  String get noMatches;

  /// No description provided for @matchCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 match} other{{n} matches}}'**
  String matchCount(int n);

  /// No description provided for @nothingHere.
  ///
  /// In en, this message translates to:
  /// **'nothing here'**
  String get nothingHere;

  /// No description provided for @emptyLexicon.
  ///
  /// In en, this message translates to:
  /// **'Nothing in this corner of the lexicon.'**
  String get emptyLexicon;

  /// No description provided for @emptySaved.
  ///
  /// In en, this message translates to:
  /// **'No saved words yet. Tap the heart on any entry.'**
  String get emptySaved;

  /// No description provided for @tapToReadMore.
  ///
  /// In en, this message translates to:
  /// **'Tap to read more'**
  String get tapToReadMore;

  /// No description provided for @saveWord.
  ///
  /// In en, this message translates to:
  /// **'Save word'**
  String get saveWord;

  /// No description provided for @removeFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get removeFromFavorites;

  /// No description provided for @inPlainWords.
  ///
  /// In en, this message translates to:
  /// **'in plain words'**
  String get inPlainWords;

  /// No description provided for @theDefinition.
  ///
  /// In en, this message translates to:
  /// **'the definition'**
  String get theDefinition;

  /// No description provided for @inASentence.
  ///
  /// In en, this message translates to:
  /// **'in a sentence'**
  String get inASentence;

  /// No description provided for @exampleGlossLabel.
  ///
  /// In en, this message translates to:
  /// **'in other words'**
  String get exampleGlossLabel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @roots.
  ///
  /// In en, this message translates to:
  /// **'roots'**
  String get roots;

  /// No description provided for @quizTitle.
  ///
  /// In en, this message translates to:
  /// **'A little quiz'**
  String get quizTitle;

  /// No description provided for @quizCaption.
  ///
  /// In en, this message translates to:
  /// **'know the roots, then choose the meaning'**
  String get quizCaption;

  /// No description provided for @quizIntro.
  ///
  /// In en, this message translates to:
  /// **'Each question shows a word and its etymology. Pick the definition that fits — four choices, one true.'**
  String get quizIntro;

  /// No description provided for @howManyWords.
  ///
  /// In en, this message translates to:
  /// **'how many words'**
  String get howManyWords;

  /// No description provided for @begin.
  ///
  /// In en, this message translates to:
  /// **'Begin'**
  String get begin;

  /// No description provided for @quizByTheme.
  ///
  /// In en, this message translates to:
  /// **'Quiz by theme'**
  String get quizByTheme;

  /// No description provided for @endQuiz.
  ///
  /// In en, this message translates to:
  /// **'End quiz'**
  String get endQuiz;

  /// No description provided for @questionOf.
  ///
  /// In en, this message translates to:
  /// **'Question {index} of {length}'**
  String questionOf(int index, int length);

  /// No description provided for @whichDefinitionFits.
  ///
  /// In en, this message translates to:
  /// **'which definition fits?'**
  String get whichDefinitionFits;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @seeResults.
  ///
  /// In en, this message translates to:
  /// **'See results'**
  String get seeResults;

  /// No description provided for @themeTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeTitle;

  /// No description provided for @chooseASubject.
  ///
  /// In en, this message translates to:
  /// **'choose a subject'**
  String get chooseASubject;

  /// No description provided for @noThemesYet.
  ///
  /// In en, this message translates to:
  /// **'No themes yet.'**
  String get noThemesYet;

  /// No description provided for @notEnoughWordsInTheme.
  ///
  /// In en, this message translates to:
  /// **'Not enough words in this theme yet.'**
  String get notEnoughWordsInTheme;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// No description provided for @perfectPage.
  ///
  /// In en, this message translates to:
  /// **'a perfect page'**
  String get perfectPage;

  /// No description provided for @wellMarked.
  ///
  /// In en, this message translates to:
  /// **'well marked'**
  String get wellMarked;

  /// No description provided for @tryAnotherRound.
  ///
  /// In en, this message translates to:
  /// **'Try another round'**
  String get tryAnotherRound;

  /// No description provided for @definitionsRight.
  ///
  /// In en, this message translates to:
  /// **'{score, plural, =1{1 definition right} other{{score} definitions right}}'**
  String definitionsRight(int score);

  /// No description provided for @definitionsRightSpoken.
  ///
  /// In en, this message translates to:
  /// **'{score, plural, =1{One definition right, of {total}.} other{{score} definitions right, of {total}.}}'**
  String definitionsRightSpoken(int score, int total);

  /// No description provided for @switchToLightMode.
  ///
  /// In en, this message translates to:
  /// **'Switch to light mode'**
  String get switchToLightMode;

  /// No description provided for @switchToDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Switch to dark mode'**
  String get switchToDarkMode;

  /// No description provided for @listen.
  ///
  /// In en, this message translates to:
  /// **'Listen'**
  String get listen;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// Do not translate. Brand name.
  ///
  /// In en, this message translates to:
  /// **'Gloss icon'**
  String get glossIcon;

  /// No description provided for @languagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languagesTitle;

  /// No description provided for @languagesCaption.
  ///
  /// In en, this message translates to:
  /// **'the tongues'**
  String get languagesCaption;

  /// No description provided for @searchLanguages.
  ///
  /// In en, this message translates to:
  /// **'Search a country or language…'**
  String get searchLanguages;

  /// No description provided for @noMatchingLanguages.
  ///
  /// In en, this message translates to:
  /// **'No matching countries or languages.'**
  String get noMatchingLanguages;

  /// No description provided for @selectedLanguage.
  ///
  /// In en, this message translates to:
  /// **'Reading in'**
  String get selectedLanguage;

  /// No description provided for @continentAfrica.
  ///
  /// In en, this message translates to:
  /// **'Africa'**
  String get continentAfrica;

  /// No description provided for @continentAsia.
  ///
  /// In en, this message translates to:
  /// **'Asia'**
  String get continentAsia;

  /// No description provided for @continentEurope.
  ///
  /// In en, this message translates to:
  /// **'Europe'**
  String get continentEurope;

  /// No description provided for @continentAmericas.
  ///
  /// In en, this message translates to:
  /// **'Americas'**
  String get continentAmericas;

  /// No description provided for @continentOceania.
  ///
  /// In en, this message translates to:
  /// **'Oceania'**
  String get continentOceania;

  /// No description provided for @currentOfTotal.
  ///
  /// In en, this message translates to:
  /// **'{current} of {total}'**
  String currentOfTotal(int current, int total);

  /// No description provided for @speechAlso.
  ///
  /// In en, this message translates to:
  /// **'Also {variants}.'**
  String speechAlso(String variants);

  /// No description provided for @speechAsIn.
  ///
  /// In en, this message translates to:
  /// **'As in: {example}'**
  String speechAsIn(String example);

  /// No description provided for @speechFrom.
  ///
  /// In en, this message translates to:
  /// **'From {origin}, {originWord}.'**
  String speechFrom(String origin, String originWord);

  /// No description provided for @speechRoot.
  ///
  /// In en, this message translates to:
  /// **'{form}, meaning {meaning}'**
  String speechRoot(String form, String meaning);

  /// No description provided for @speechInPlainWords.
  ///
  /// In en, this message translates to:
  /// **'In plain words: {friendly}'**
  String speechInPlainWords(String friendly);

  /// No description provided for @categorySpeech.
  ///
  /// In en, this message translates to:
  /// **'Speech & Rhetoric'**
  String get categorySpeech;

  /// No description provided for @categoryCharacter.
  ///
  /// In en, this message translates to:
  /// **'Character & Temperament'**
  String get categoryCharacter;

  /// No description provided for @categoryCriticism.
  ///
  /// In en, this message translates to:
  /// **'Criticism & Insult'**
  String get categoryCriticism;

  /// No description provided for @categoryVirtue.
  ///
  /// In en, this message translates to:
  /// **'Virtue'**
  String get categoryVirtue;

  /// No description provided for @categoryVice.
  ///
  /// In en, this message translates to:
  /// **'Vice'**
  String get categoryVice;

  /// No description provided for @categoryKnowledge.
  ///
  /// In en, this message translates to:
  /// **'Knowledge & Thought'**
  String get categoryKnowledge;

  /// No description provided for @categoryReligion.
  ///
  /// In en, this message translates to:
  /// **'Religion & Spirit'**
  String get categoryReligion;

  /// No description provided for @categoryBeginnings.
  ///
  /// In en, this message translates to:
  /// **'Beginnings'**
  String get categoryBeginnings;

  /// No description provided for @categoryConflict.
  ///
  /// In en, this message translates to:
  /// **'Conflict & Deceit'**
  String get categoryConflict;

  /// No description provided for @categoryAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance & Light'**
  String get categoryAppearance;

  /// No description provided for @categoryPeople.
  ///
  /// In en, this message translates to:
  /// **'People & Roles'**
  String get categoryPeople;

  /// No description provided for @categoryObjects.
  ///
  /// In en, this message translates to:
  /// **'Objects & Things'**
  String get categoryObjects;

  /// No description provided for @categoryEmotion.
  ///
  /// In en, this message translates to:
  /// **'Emotion'**
  String get categoryEmotion;

  /// No description provided for @categoryArchaic.
  ///
  /// In en, this message translates to:
  /// **'Old & Archaic'**
  String get categoryArchaic;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'af',
        'ar',
        'az',
        'be',
        'bg',
        'bn',
        'cs',
        'da',
        'de',
        'el',
        'en',
        'es',
        'et',
        'fi',
        'fil',
        'fr',
        'he',
        'hi',
        'hr',
        'hu',
        'hy',
        'id',
        'is',
        'it',
        'ja',
        'ka',
        'kk',
        'km',
        'ko',
        'ky',
        'lo',
        'lt',
        'lv',
        'mk',
        'ms',
        'my',
        'nb',
        'ne',
        'nl',
        'pl',
        'pt',
        'ro',
        'ru',
        'si',
        'sk',
        'sl',
        'sq',
        'sr',
        'sv',
        'sw',
        'th',
        'tr',
        'uk',
        'ur',
        'vi',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'es':
      {
        switch (locale.countryCode) {
          case '419':
            return AppLocalizationsEs419();
        }
        break;
      }
    case 'fr':
      {
        switch (locale.countryCode) {
          case 'CA':
            return AppLocalizationsFrCa();
        }
        break;
      }
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'HK':
            return AppLocalizationsZhHk();
          case 'TW':
            return AppLocalizationsZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af':
      return AppLocalizationsAf();
    case 'ar':
      return AppLocalizationsAr();
    case 'az':
      return AppLocalizationsAz();
    case 'be':
      return AppLocalizationsBe();
    case 'bg':
      return AppLocalizationsBg();
    case 'bn':
      return AppLocalizationsBn();
    case 'cs':
      return AppLocalizationsCs();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'et':
      return AppLocalizationsEt();
    case 'fi':
      return AppLocalizationsFi();
    case 'fil':
      return AppLocalizationsFil();
    case 'fr':
      return AppLocalizationsFr();
    case 'he':
      return AppLocalizationsHe();
    case 'hi':
      return AppLocalizationsHi();
    case 'hr':
      return AppLocalizationsHr();
    case 'hu':
      return AppLocalizationsHu();
    case 'hy':
      return AppLocalizationsHy();
    case 'id':
      return AppLocalizationsId();
    case 'is':
      return AppLocalizationsIs();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ka':
      return AppLocalizationsKa();
    case 'kk':
      return AppLocalizationsKk();
    case 'km':
      return AppLocalizationsKm();
    case 'ko':
      return AppLocalizationsKo();
    case 'ky':
      return AppLocalizationsKy();
    case 'lo':
      return AppLocalizationsLo();
    case 'lt':
      return AppLocalizationsLt();
    case 'lv':
      return AppLocalizationsLv();
    case 'mk':
      return AppLocalizationsMk();
    case 'ms':
      return AppLocalizationsMs();
    case 'my':
      return AppLocalizationsMy();
    case 'nb':
      return AppLocalizationsNb();
    case 'ne':
      return AppLocalizationsNe();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'si':
      return AppLocalizationsSi();
    case 'sk':
      return AppLocalizationsSk();
    case 'sl':
      return AppLocalizationsSl();
    case 'sq':
      return AppLocalizationsSq();
    case 'sr':
      return AppLocalizationsSr();
    case 'sv':
      return AppLocalizationsSv();
    case 'sw':
      return AppLocalizationsSw();
    case 'th':
      return AppLocalizationsTh();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
    case 'ur':
      return AppLocalizationsUr();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
