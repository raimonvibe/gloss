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
  String get navStudy => '書斎';

  @override
  String get studyTitle => '書斎';

  @override
  String get studyCaption => '読むこと、声、灯り';

  @override
  String get readingSection => '読むこと';

  @override
  String get readingCaption => '頁のたたずまい';

  @override
  String get textSize => '文字の大きさ';

  @override
  String get textSizeSample => 'Edulcorate — 甘くすること、和らげること。';

  @override
  String get smaller => '小さく';

  @override
  String get larger => '大きく';

  @override
  String get autoplayPronunciation => '開いたときに語を読み上げる';

  @override
  String get reduceMotion => '装飾を静める';

  @override
  String get reduceMotionCaption => '飾りとグラデーションを控えめに';

  @override
  String get voiceSection => '声';

  @override
  String get voiceCaption => 'Gloss の読み上げかた';

  @override
  String get chooseVoice => '声';

  @override
  String get voiceDefault => 'おまかせ';

  @override
  String get noOtherVoices => 'この端末には他の英語の声がインストールされていません。';

  @override
  String get speechPace => '速さ';

  @override
  String get slower => 'ゆっくり';

  @override
  String get faster => '速く';

  @override
  String get hearIt => '聞いてみる';

  @override
  String get lightSection => '灯り';

  @override
  String get lightCaption => '羊皮紙か蝋燭の灯か';

  @override
  String get themeSystem => '端末に合わせる';

  @override
  String get themeLight => '羊皮紙';

  @override
  String get themeDark => '蝋燭の灯';

  @override
  String get tongueSection => '言葉';

  @override
  String get aboutSection => 'このアプリについて';

  @override
  String get aboutCaption => 'つくられかた';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'オープンソースライセンス';

  @override
  String get shareGloss => 'Gloss を共有';

  @override
  String get followTheMaker => '作り手をフォロー';

  @override
  String couldNotOpenLink(String label) {
    return '$label を開けませんでした。';
  }

  @override
  String readExplanationsIn(String language) {
    return '$language で解説を読む';
  }

  @override
  String get readExplanationsCaption => '語そのものは常に英語で読み上げられます。';

  @override
  String noVoiceInstalled(String language) {
    return 'この端末には $language の声がインストールされていません。';
  }

  @override
  String get memorySection => '記憶';

  @override
  String get memoryCaption => 'Gloss が覚えていること';

  @override
  String get forgetProgress => '進み具合を忘れる';

  @override
  String get forgetProgressBody => '読んだ語の印が外れます。保存した語はそのまま残ります。';

  @override
  String get clearSavedWords => '保存した語を消す';

  @override
  String get clearSavedWordsBody => '手元に置いた語が削除されます。進み具合はそのまま残ります。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get forget => '忘れる';

  @override
  String get clear => '消す';

  @override
  String get progressForgotten => '進み具合を忘れました。';

  @override
  String get savedWordsCleared => '保存した語を消しました。';

  @override
  String get contactTitle => '作者に手紙を書く';

  @override
  String get contactCaption => 'よろしければ、一通の手紙を';

  @override
  String get contactBlurb =>
      'Gloss は一人の手で作られています。足りない言葉、見つけた誤り、気に入った一行 — どれも同じ机に届きます。';

  @override
  String get contactLetterSection => '手紙';

  @override
  String get contactName => 'お名前';

  @override
  String get contactNameHint => 'お呼びするお名前';

  @override
  String get contactEmail => 'メールアドレス';

  @override
  String get contactEmailHint => '返信が届く場所';

  @override
  String contactEmailTypo(String domain) {
    return '$domain のことでしょうか。';
  }

  @override
  String get contactReason => '書く理由';

  @override
  String get reasonWord => '加えたい言葉';

  @override
  String get reasonProblem => '何かがおかしい';

  @override
  String get reasonQuestion => '質問';

  @override
  String get reasonPraise => 'ご意見';

  @override
  String get reasonOther => 'そのほか';

  @override
  String get contactPriority => '急ぎの度合い';

  @override
  String get priorityLow => '低い';

  @override
  String get priorityNormal => 'ふつう';

  @override
  String get priorityHigh => '高い';

  @override
  String get contactMessage => 'ご用件';

  @override
  String get contactMessageHint => '長くても短くても、お好きなだけどうぞ…';

  @override
  String get contactHumanCheck => '送る前にひとつだけ';

  @override
  String contactHumanQuestion(String word) {
    return '$word に当てはまる意味はどれでしょう。';
  }

  @override
  String get contactHumanRetry => 'それではありません。別の言葉をどうぞ。';

  @override
  String get contactDetails => 'アプリの情報を添える';

  @override
  String get contactDetailsCaption => '版、言語、明かり、文字の大きさ。不具合を見つけやすくなります。';

  @override
  String get contactSend => '手紙を送る';

  @override
  String get contactCopyLetter => '手紙をコピー';

  @override
  String get contactDraftRestored => '送られていない手紙が残っていました。';

  @override
  String get contactNoMailApp => 'メールアプリが応じませんでした。手紙はクリップボードにあります。';

  @override
  String get contactNeedName => 'お名前を。返信が誰に宛てるか分かるように。';

  @override
  String get contactNeedEmail => '返信の届く宛先を。';

  @override
  String get contactNeedMessage => 'せめて一行か二行を。';

  @override
  String get contactSent => 'お手紙をお預かりしました。ありがとうございます。';

  @override
  String get contactSendFailed => 'いまは送れませんでした。手紙はクリップボードにあり、ここにも残しています。';

  @override
  String get contactSendByMail => '代わりにメールアプリを使う';
}
