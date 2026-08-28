// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => '美しいことばの語彙集';

  @override
  String get navHome => 'ホーム';

  @override
  String get navLexicon => '語彙集';

  @override
  String get navQuiz => 'クイズ';

  @override
  String get navSaved => '保存';

  @override
  String get navLanguages => '言語';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$lexicon の語彙集から、めずらしく豊かなことば $count — 辞書ではなく、友人のように解きほぐしてあります。';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$total 語のうち $current 語をたどりました';
  }

  @override
  String get exploreLexicon => '語彙集をひらく';

  @override
  String get startQuiz => 'クイズをはじめる';

  @override
  String get wordOfTheDay => 'きょうの一語';

  @override
  String get readFullEntry => '項目をすべて読む →';

  @override
  String get lexiconTitle => '語彙集';

  @override
  String get lexiconCaption => '集まり';

  @override
  String get savedTitle => '保存したことば';

  @override
  String get savedCaption => 'そばに置いて';

  @override
  String get searchHint => 'ことばを探すか、意味を書いてみて…';

  @override
  String get clearSearch => '検索を消す';

  @override
  String get filterAll => 'すべて';

  @override
  String get noMatches => 'まだ見つかりません — 別のことばや気分で試してみて。';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n 件',
      one: '1 件',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'ここには何もありません';

  @override
  String get emptyLexicon => '語彙集のこのすみには、まだ何もありません。';

  @override
  String get emptySaved => 'まだ保存したことばはありません。項目のハートをタップして。';

  @override
  String get tapToReadMore => 'タップして続きを読む';

  @override
  String get saveWord => 'ことばを保存';

  @override
  String get removeFromFavorites => 'お気に入りから外す';

  @override
  String get inPlainWords => 'やさしいことばで';

  @override
  String get theDefinition => '定義';

  @override
  String get inASentence => '文のなかで';

  @override
  String get exampleGlossLabel => '言い換えれば';

  @override
  String get save => '保存';

  @override
  String get saved => '保存済み';

  @override
  String get copy => 'コピー';

  @override
  String get copiedToClipboard => 'クリップボードにコピーしました';

  @override
  String get roots => '語根';

  @override
  String get quizTitle => 'ささやかなクイズ';

  @override
  String get quizCaption => '語根を知り、それから意味を選ぶ';

  @override
  String get quizIntro => '各問にことばとその語源が出ます。あてはまる定義を選んでください — 四つのうち、一つが正解。';

  @override
  String get howManyWords => 'いくつのことば';

  @override
  String get begin => 'はじめる';

  @override
  String get quizByTheme => 'テーマ別クイズ';

  @override
  String get endQuiz => 'クイズを終わる';

  @override
  String questionOf(int index, int length) {
    return '第 $index 問 / $length';
  }

  @override
  String get whichDefinitionFits => 'どの定義があてはまりますか？';

  @override
  String get previous => '前へ';

  @override
  String get next => '次へ';

  @override
  String get seeResults => '結果を見る';

  @override
  String get themeTitle => 'テーマ';

  @override
  String get chooseASubject => '題を選ぶ';

  @override
  String get noThemesYet => 'まだテーマがありません。';

  @override
  String get notEnoughWordsInTheme => 'このテーマにはまだことばが足りません。';

  @override
  String get results => '結果';

  @override
  String get perfectPage => '完璧な一頁';

  @override
  String get wellMarked => 'よく記された';

  @override
  String get tryAnotherRound => 'もう一度ためす';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '正解 $score',
      one: '正解 1',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$total 問のうち、定義が $score 問正解です。',
      one: '$total 問のうち、定義が一つ正解です。',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'ライトモードに切り替える';

  @override
  String get switchToDarkMode => 'ダークモードに切り替える';

  @override
  String get listen => '聞く';

  @override
  String get stop => '止める';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => '言語';

  @override
  String get languagesCaption => 'ことばたち';

  @override
  String get searchLanguages => '国や言語を探す…';

  @override
  String get noMatchingLanguages => '一致する国や言語はありません。';

  @override
  String get selectedLanguage => '読む言語';

  @override
  String get continentAfrica => 'アフリカ';

  @override
  String get continentAsia => 'アジア';

  @override
  String get continentEurope => 'ヨーロッパ';

  @override
  String get continentAmericas => 'アメリカ';

  @override
  String get continentOceania => 'オセアニア';

  @override
  String currentOfTotal(int current, int total) {
    return '$current / $total';
  }

  @override
  String speechAlso(String variants) {
    return 'また $variants。';
  }

  @override
  String speechAsIn(String example) {
    return 'たとえば：$example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '$origin の $originWord から。';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form、意味は $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'やさしいことばで：$friendly';
  }

  @override
  String get categorySpeech => '話ことばと修辞';

  @override
  String get categoryCharacter => '気質と性格';

  @override
  String get categoryCriticism => '批評と罵倒';

  @override
  String get categoryVirtue => '美徳';

  @override
  String get categoryVice => '悪徳';

  @override
  String get categoryKnowledge => '知と思索';

  @override
  String get categoryReligion => '宗教と精神';

  @override
  String get categoryBeginnings => '始まり';

  @override
  String get categoryConflict => '争いと欺き';

  @override
  String get categoryAppearance => '姿とかたち、光';

  @override
  String get categoryPeople => '人と役割';

  @override
  String get categoryObjects => 'ものとうつわ';

  @override
  String get categoryEmotion => '感情';

  @override
  String get categoryArchaic => '古語と雅語';

  @override
  String get navStudy => 'Study';

  @override
  String get studyTitle => 'The study';

  @override
  String get studyCaption => 'reading, voice, and light';

  @override
  String get readingSection => 'Reading';

  @override
  String get readingCaption => 'how the page sits';

  @override
  String get textSize => 'Text size';

  @override
  String get textSizeSample => 'Edulcorate — to sweeten, to soften.';

  @override
  String get smaller => 'Smaller';

  @override
  String get larger => 'Larger';

  @override
  String get autoplayPronunciation => 'Read a word aloud when it opens';

  @override
  String get reduceMotion => 'Calm the ornaments';

  @override
  String get reduceMotionCaption => 'fewer flourishes and gradients';

  @override
  String get voiceSection => 'Voice';

  @override
  String get voiceCaption => 'how Gloss reads aloud';

  @override
  String get chooseVoice => 'Voice';

  @override
  String get voiceDefault => 'Chosen for you';

  @override
  String get noOtherVoices =>
      'No other English voices are installed on this device.';

  @override
  String get speechPace => 'Pace';

  @override
  String get slower => 'Slower';

  @override
  String get faster => 'Faster';

  @override
  String get hearIt => 'Hear it';

  @override
  String get lightSection => 'Light';

  @override
  String get lightCaption => 'parchment or candlelight';

  @override
  String get themeSystem => 'Match device';

  @override
  String get themeLight => 'Parchment';

  @override
  String get themeDark => 'Candlelight';

  @override
  String get tongueSection => 'Tongue';

  @override
  String get aboutSection => 'About';

  @override
  String get aboutCaption => 'the making of it';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Open-source licences';

  @override
  String get shareGloss => 'Share Gloss';

  @override
  String get followTheMaker => 'Follow the maker';

  @override
  String couldNotOpenLink(String label) {
    return 'Could not open $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Read explanations in $language';
  }

  @override
  String get readExplanationsCaption =>
      'The word itself is always read in English.';

  @override
  String noVoiceInstalled(String language) {
    return 'This device has no $language voice installed.';
  }
}
