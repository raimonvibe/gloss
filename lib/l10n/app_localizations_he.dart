// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'לקסיקון של לשון יפה';

  @override
  String get navHome => 'בית';

  @override
  String get navLexicon => 'לקסיקון';

  @override
  String get navQuiz => 'חידון';

  @override
  String get navSaved => 'שמורים';

  @override
  String get navLanguages => 'שפות';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count מילים נדירות ועשירות מלקסיקון $lexicon — מוסברות כפי שחבר היה מסביר, לא כמילון.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'נחקרו $current מתוך $total מילים';
  }

  @override
  String get exploreLexicon => 'חקור את הלקסיקון';

  @override
  String get startQuiz => 'התחל חידון';

  @override
  String get wordOfTheDay => 'מילת היום';

  @override
  String get readFullEntry => 'קרא את הערך המלא →';

  @override
  String get lexiconTitle => 'הלקסיקון';

  @override
  String get lexiconCaption => 'האסופה';

  @override
  String get savedTitle => 'מילים שמורות';

  @override
  String get savedCaption => 'קרובות ללב';

  @override
  String get searchHint => 'חפש מילה, או תאר את משמעותה…';

  @override
  String get clearSearch => 'נקה חיפוש';

  @override
  String get filterAll => 'הכול';

  @override
  String get noMatches => 'עדיין אין התאמות — נסה מילה או תחושה אחרת.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n התאמות',
      one: 'התאמה אחת',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'אין כאן דבר';

  @override
  String get emptyLexicon => 'אין דבר בפינה זו של הלקסיקון.';

  @override
  String get emptySaved => 'עדיין אין מילים שמורות. הקש על הלב בכל ערך.';

  @override
  String get tapToReadMore => 'הקש כדי לקרוא עוד';

  @override
  String get saveWord => 'שמור מילה';

  @override
  String get removeFromFavorites => 'הסר מהמועדפים';

  @override
  String get inPlainWords => 'במילים פשוטות';

  @override
  String get theDefinition => 'ההגדרה';

  @override
  String get inASentence => 'במשפט';

  @override
  String get exampleGlossLabel => 'במילים אחרות';

  @override
  String get save => 'שמירה';

  @override
  String get saved => 'שמור';

  @override
  String get copy => 'העתקה';

  @override
  String get copiedToClipboard => 'הועתק ללוח';

  @override
  String get roots => 'שורשים';

  @override
  String get quizTitle => 'חידון קטן';

  @override
  String get quizCaption => 'הכר את השורשים, ואז בחר את המשמעות';

  @override
  String get quizIntro =>
      'כל שאלה מציגה מילה ואת האטימולוגיה שלה. בחר את ההגדרה המתאימה — ארבע אפשרויות, אחת נכונה.';

  @override
  String get howManyWords => 'כמה מילים';

  @override
  String get begin => 'התחל';

  @override
  String get quizByTheme => 'חידון לפי נושא';

  @override
  String get endQuiz => 'סיים חידון';

  @override
  String questionOf(int index, int length) {
    return 'שאלה $index מתוך $length';
  }

  @override
  String get whichDefinitionFits => 'איזו הגדרה מתאימה?';

  @override
  String get previous => 'הקודם';

  @override
  String get next => 'הבא';

  @override
  String get seeResults => 'ראה תוצאות';

  @override
  String get themeTitle => 'נושא';

  @override
  String get chooseASubject => 'בחר נושא';

  @override
  String get noThemesYet => 'עדיין אין נושאים.';

  @override
  String get notEnoughWordsInTheme => 'עדיין אין די מילים בנושא זה.';

  @override
  String get results => 'תוצאות';

  @override
  String get perfectPage => 'עמוד מושלם';

  @override
  String get wellMarked => 'סומן יפה';

  @override
  String get tryAnotherRound => 'נסה סבב נוסף';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score הגדרות נכונות',
      one: 'הגדרה נכונה אחת',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score הגדרות נכונות, מתוך $total.',
      one: 'הגדרה נכונה אחת, מתוך $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'עבור למצב בהיר';

  @override
  String get switchToDarkMode => 'עבור למצב כהה';

  @override
  String get listen => 'האזן';

  @override
  String get stop => 'עצור';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'שפות';

  @override
  String get languagesCaption => 'הלשונות';

  @override
  String get searchLanguages => 'חפש מדינה או שפה…';

  @override
  String get noMatchingLanguages => 'אין מדינות או שפות תואמות.';

  @override
  String get selectedLanguage => 'קריאה ב';

  @override
  String get continentAfrica => 'אפריקה';

  @override
  String get continentAsia => 'אסיה';

  @override
  String get continentEurope => 'אירופה';

  @override
  String get continentAmericas => 'אמריקה';

  @override
  String get continentOceania => 'אוקיאניה';

  @override
  String currentOfTotal(int current, int total) {
    return '$current מתוך $total';
  }

  @override
  String speechAlso(String variants) {
    return 'גם $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'כמו ב: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'מ$origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, משמעות $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'במילים פשוטות: $friendly';
  }

  @override
  String get categorySpeech => 'דיבור ורטוריקה';

  @override
  String get categoryCharacter => 'אופי ומזג';

  @override
  String get categoryCriticism => 'ביקורת ועלבון';

  @override
  String get categoryVirtue => 'מידה טובה';

  @override
  String get categoryVice => 'חטא';

  @override
  String get categoryKnowledge => 'דעת ומחשבה';

  @override
  String get categoryReligion => 'דת ורוח';

  @override
  String get categoryBeginnings => 'התחלות';

  @override
  String get categoryConflict => 'סכסוך ותרמית';

  @override
  String get categoryAppearance => 'מראה ואור';

  @override
  String get categoryPeople => 'אנשים ותפקידים';

  @override
  String get categoryObjects => 'חפצים ודברים';

  @override
  String get categoryEmotion => 'רגש';

  @override
  String get categoryArchaic => 'ישן וארכאי';
}
