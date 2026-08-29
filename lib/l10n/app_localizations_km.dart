// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Khmer Central Khmer (`km`).
class AppLocalizationsKm extends AppLocalizations {
  AppLocalizationsKm([String locale = 'km']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'វចនានុក្រមនៃភាសាដ៏ស្រស់ស្អាត';

  @override
  String get navHome => 'ទំព័រដើម';

  @override
  String get navLexicon => 'វចនានុក្រម';

  @override
  String get navQuiz => 'សំណួរ';

  @override
  String get navSaved => 'បានរក្សាទុក';

  @override
  String get navLanguages => 'ភាសា';

  @override
  String homeBlurb(int count, String lexicon) {
    return 'ពាក្យកម្រនិងសម្បូរបែប $count ពីវចនានុក្រម $lexicon — ពន្យល់ដូចមិត្តភក្តិ មិនមែនដូចវចនានុក្រមទេ។';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'បានស្វែងយល់ $current ក្នុង $total ពាក្យ';
  }

  @override
  String get exploreLexicon => 'ស្វែងយល់វចនានុក្រម';

  @override
  String get startQuiz => 'ចាប់ផ្តើមសំណួរ';

  @override
  String get wordOfTheDay => 'ពាក្យប្រចាំថ្ងៃ';

  @override
  String get readFullEntry => 'អានធាតុពេញ →';

  @override
  String get lexiconTitle => 'វចនានុក្រម';

  @override
  String get lexiconCaption => 'ការប្រមូល';

  @override
  String get savedTitle => 'ពាក្យដែលបានរក្សាទុក';

  @override
  String get savedCaption => 'រក្សាទុកជិត';

  @override
  String get searchHint => 'ស្វែងរកពាក្យ ឬពិពណ៌នាអត្ថន័យ…';

  @override
  String get clearSearch => 'សម្អាតការស្វែងរក';

  @override
  String get filterAll => 'ទាំងអស់';

  @override
  String get noMatches => 'មិនទាន់មានលទ្ធផល — សាកពាក្យ ឬអារម្មណ៍ផ្សេង។';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n លទ្ធផល',
      one: '១ លទ្ធផល',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'គ្មានអ្វីនៅទីនេះ';

  @override
  String get emptyLexicon => 'គ្មានអ្វីនៅជ្រុងនេះនៃវចនានុក្រម។';

  @override
  String get emptySaved => 'មិនទាន់មានពាក្យរក្សាទុក។ ប៉ះបេះដូងលើធាតុណាមួយ។';

  @override
  String get tapToReadMore => 'ប៉ះដើម្បីអានបន្ថែម';

  @override
  String get saveWord => 'រក្សាទុកពាក្យ';

  @override
  String get removeFromFavorites => 'ដកចេញពីសំណព្វ';

  @override
  String get inPlainWords => 'ជាពាក្យសាមញ្ញ';

  @override
  String get theDefinition => 'និយមន័យ';

  @override
  String get inASentence => 'ក្នុងប្រយោគ';

  @override
  String get exampleGlossLabel => 'និយាយម្យ៉ាងទៀត';

  @override
  String get save => 'រក្សាទុក';

  @override
  String get saved => 'បានរក្សាទុក';

  @override
  String get copy => 'ចម្លង';

  @override
  String get copiedToClipboard => 'បានចម្លងទៅក្ដារតម្បៀតខ្ទាស់';

  @override
  String get roots => 'ឫស';

  @override
  String get quizTitle => 'សំណួរតូចមួយ';

  @override
  String get quizCaption => 'ស្គាល់ឫស រួចជ្រើសអត្ថន័យ';

  @override
  String get quizIntro =>
      'រាល់សំណួរបង្ហាញពាក្យ និងនិរុត្តិសាស្ត្រ។ ជ្រើសនិយមន័យដែលសម — បួនជម្រើស មួយត្រឹមត្រូវ។';

  @override
  String get howManyWords => 'ប៉ុន្មានពាក្យ';

  @override
  String get begin => 'ចាប់ផ្តើម';

  @override
  String get quizByTheme => 'សំណួរតាមប្រធានបទ';

  @override
  String get endQuiz => 'បញ្ចប់សំណួរ';

  @override
  String questionOf(int index, int length) {
    return 'សំណួរ $index នៃ $length';
  }

  @override
  String get whichDefinitionFits => 'និយមន័យណាសម?';

  @override
  String get previous => 'មុន';

  @override
  String get next => 'បន្ទាប់';

  @override
  String get seeResults => 'មើលលទ្ធផល';

  @override
  String get themeTitle => 'ប្រធានបទ';

  @override
  String get chooseASubject => 'ជ្រើសប្រធានបទ';

  @override
  String get noThemesYet => 'មិនទាន់មានប្រធានបទ។';

  @override
  String get notEnoughWordsInTheme =>
      'មិនទាន់មានពាក្យគ្រប់គ្រាន់ក្នុងប្រធានបទនេះ។';

  @override
  String get results => 'លទ្ធផល';

  @override
  String get perfectPage => 'ទំព័រល្អឥតខ្ចោះ';

  @override
  String get wellMarked => 'បានសម្គាល់យ៉ាងស្អាត';

  @override
  String get tryAnotherRound => 'សាកជុំមួយទៀត';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: 'និយមន័យត្រឹមត្រូវ $score',
      one: 'និយមន័យត្រឹមត្រូវ ១',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: 'និយមន័យត្រឹមត្រូវ $score ក្នុង $total។',
      one: 'និយមន័យត្រឹមត្រូវមួយ ក្នុង $total។',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'ប្ដូរទៅរបៀបភ្លឺ';

  @override
  String get switchToDarkMode => 'ប្ដូរទៅរបៀបងងឹត';

  @override
  String get listen => 'ស្តាប់';

  @override
  String get stop => 'ឈប់';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'ភាសា';

  @override
  String get languagesCaption => 'អណ្ដាត';

  @override
  String get searchLanguages => 'ស្វែងរកប្រទេស ឬភាសា…';

  @override
  String get noMatchingLanguages => 'គ្មានប្រទេស ឬភាសាដែលត្រូវគ្នា។';

  @override
  String get selectedLanguage => 'កំពុងអានជា';

  @override
  String get continentAfrica => 'អាហ្វ្រិក';

  @override
  String get continentAsia => 'អាស៊ី';

  @override
  String get continentEurope => 'អឺរ៉ុប';

  @override
  String get continentAmericas => 'អាមេរិក';

  @override
  String get continentOceania => 'អូសេអានី';

  @override
  String currentOfTotal(int current, int total) {
    return '$current នៃ $total';
  }

  @override
  String speechAlso(String variants) {
    return 'ក៏មាន $variants។';
  }

  @override
  String speechAsIn(String example) {
    return 'ដូចក្នុង៖ $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'ពី $origin, $originWord។';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form មានន័យថា $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'ជាពាក្យសាមញ្ញ៖ $friendly';
  }

  @override
  String get categorySpeech => 'សុន្ទរកថា និងវោហារសាស្ត្រ';

  @override
  String get categoryCharacter => 'ចរិត និងនិស្ស័យ';

  @override
  String get categoryCriticism => 'ការរិះគន់ និងការប្រមាថ';

  @override
  String get categoryVirtue => 'គុណធម៌';

  @override
  String get categoryVice => 'អំពើអាក្រក់';

  @override
  String get categoryKnowledge => 'ចំណេះដឹង និងគំនិត';

  @override
  String get categoryReligion => 'សាសនា និងវិញ្ញាណ';

  @override
  String get categoryBeginnings => 'ការចាប់ផ្តើម';

  @override
  String get categoryConflict => 'ជម្លោះ និងការបោកបញ្ឆោត';

  @override
  String get categoryAppearance => 'រូបរាង និងពន្លឺ';

  @override
  String get categoryPeople => 'មនុស្ស និងតួនាទី';

  @override
  String get categoryObjects => 'វត្ថុ និងរបស់';

  @override
  String get categoryEmotion => 'អារម្មណ៍';

  @override
  String get categoryArchaic => 'ចាស់ និងបុរាណ';

  @override
  String get navStudy => 'បន្ទប់សិក្សា';

  @override
  String get studyTitle => 'បន្ទប់សិក្សា';

  @override
  String get studyCaption => 'ការអាន សំឡេង និងពន្លឺ';

  @override
  String get readingSection => 'ការអាន';

  @override
  String get readingCaption => 'របៀបដែលទំព័រអង្គុយ';

  @override
  String get textSize => 'ទំហំអក្សរ';

  @override
  String get textSizeSample => 'Edulcorate — ធ្វើឱ្យផ្អែម ធ្វើឱ្យទន់។';

  @override
  String get smaller => 'តូចជាង';

  @override
  String get larger => 'ធំជាង';

  @override
  String get autoplayPronunciation => 'អានពាក្យឮៗពេលបើក';

  @override
  String get reduceMotion => 'បន្ថយការតុបតែង';

  @override
  String get reduceMotionCaption => 'តិចជាងនូវក្បាច់និងពណ៌លាយ';

  @override
  String get voiceSection => 'សំឡេង';

  @override
  String get voiceCaption => 'របៀបដែល Gloss អានឮៗ';

  @override
  String get chooseVoice => 'សំឡេង';

  @override
  String get voiceDefault => 'ជ្រើសរើសសម្រាប់អ្នក';

  @override
  String get noOtherVoices =>
      'គ្មានសំឡេងអង់គ្លេសផ្សេងទៀតត្រូវបានដំឡើងនៅលើឧបករណ៍នេះទេ។';

  @override
  String get speechPace => 'ល្បឿន';

  @override
  String get slower => 'យឺតជាង';

  @override
  String get faster => 'លឿនជាង';

  @override
  String get hearIt => 'ស្តាប់';

  @override
  String get lightSection => 'ពន្លឺ';

  @override
  String get lightCaption => 'ក្រដាសស្បែក ឬពន្លឺទៀន';

  @override
  String get themeSystem => 'តាមឧបករណ៍';

  @override
  String get themeLight => 'ក្រដាសស្បែក';

  @override
  String get themeDark => 'ពន្លឺទៀន';

  @override
  String get tongueSection => 'ភាសា';

  @override
  String get aboutSection => 'អំពី';

  @override
  String get aboutCaption => 'របៀបដែលវាត្រូវបានបង្កើត';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'អាជ្ញាបណ្ណប្រភពបើកចំហ';

  @override
  String get shareGloss => 'ចែករំលែក Gloss';

  @override
  String get followTheMaker => 'តាមដានអ្នកបង្កើត';

  @override
  String couldNotOpenLink(String label) {
    return 'មិនអាចបើក $label បានទេ។';
  }

  @override
  String readExplanationsIn(String language) {
    return 'អានការពន្យល់ជាភាសា $language';
  }

  @override
  String get readExplanationsCaption =>
      'ពាក្យនេះតែងតែត្រូវបានអានជាភាសាអង់គ្លេស។';

  @override
  String noVoiceInstalled(String language) {
    return 'ឧបករណ៍នេះមិនមានសំឡេង $language ដំឡើងទេ។';
  }
}
