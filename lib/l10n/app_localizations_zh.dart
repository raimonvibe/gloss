// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => '優美語言的詞彙集';

  @override
  String get navHome => '首頁';

  @override
  String get navLexicon => '詞彙集';

  @override
  String get navQuiz => '測驗';

  @override
  String get navSaved => '已儲存';

  @override
  String get navLanguages => '語言';

  @override
  String homeBlurb(int count, String lexicon) {
    return '來自$lexicon詞彙集的$count個罕見而豐美的詞——像朋友解說，而不是字典。';
  }

  @override
  String wordsExplored(int current, int total) {
    return '已閱覽 $current／$total 個詞';
  }

  @override
  String get exploreLexicon => '瀏覽詞彙集';

  @override
  String get startQuiz => '開始測驗';

  @override
  String get wordOfTheDay => '今日一字';

  @override
  String get readFullEntry => '閱讀全文 →';

  @override
  String get lexiconTitle => '詞彙集';

  @override
  String get lexiconCaption => '匯集';

  @override
  String get savedTitle => '已儲存的詞';

  @override
  String get savedCaption => '收藏近身';

  @override
  String get searchHint => '搜尋一個詞，或描述它的意思…';

  @override
  String get clearSearch => '清除搜尋';

  @override
  String get filterAll => '全部';

  @override
  String get noMatches => '尚無結果——試試另一個詞或感覺。';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n 個結果',
      one: '1 個結果',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => '這裡什麼也沒有';

  @override
  String get emptyLexicon => '詞彙集這一角空無一物。';

  @override
  String get emptySaved => '尚未儲存任何詞。在任何條目輕觸愛心。';

  @override
  String get tapToReadMore => '輕觸以閱讀更多';

  @override
  String get saveWord => '儲存詞語';

  @override
  String get removeFromFavorites => '從收藏移除';

  @override
  String get inPlainWords => '淺白來說';

  @override
  String get theDefinition => '定義';

  @override
  String get inASentence => '句中';

  @override
  String get exampleGlossLabel => '換言之';

  @override
  String get save => '儲存';

  @override
  String get saved => '已儲存';

  @override
  String get copy => '複製';

  @override
  String get copiedToClipboard => '已複製到剪貼簿';

  @override
  String get roots => '詞根';

  @override
  String get quizTitle => '一小道測驗';

  @override
  String get quizCaption => '先識詞根，再選意思';

  @override
  String get quizIntro => '每題顯示一個詞及其語源。選出合適的定義——四個選擇，一個正確。';

  @override
  String get howManyWords => '多少個詞';

  @override
  String get begin => '開始';

  @override
  String get quizByTheme => '依主題測驗';

  @override
  String get endQuiz => '結束測驗';

  @override
  String questionOf(int index, int length) {
    return '第 $index 題／共 $length 題';
  }

  @override
  String get whichDefinitionFits => '哪個定義合適？';

  @override
  String get previous => '上一題';

  @override
  String get next => '下一題';

  @override
  String get seeResults => '查看成績';

  @override
  String get themeTitle => '主題';

  @override
  String get chooseASubject => '選一個題目';

  @override
  String get noThemesYet => '尚無主題。';

  @override
  String get notEnoughWordsInTheme => '這個主題尚無足夠的詞。';

  @override
  String get results => '成績';

  @override
  String get perfectPage => '完美的一頁';

  @override
  String get wellMarked => '標記得宜';

  @override
  String get tryAnotherRound => '再試一回';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '答對 $score 個定義',
      one: '答對 1 個定義',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '共 $total 題，答對 $score 個定義。',
      one: '共 $total 題，答對一個定義。',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => '切換至淺色模式';

  @override
  String get switchToDarkMode => '切換至深色模式';

  @override
  String get listen => '聆聽';

  @override
  String get stop => '停止';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => '語言';

  @override
  String get languagesCaption => '眾舌';

  @override
  String get searchLanguages => '搜尋國家或語言…';

  @override
  String get noMatchingLanguages => '沒有相符的國家或語言。';

  @override
  String get selectedLanguage => '閱讀語言';

  @override
  String get continentAfrica => '非洲';

  @override
  String get continentAsia => '亞洲';

  @override
  String get continentEurope => '歐洲';

  @override
  String get continentAmericas => '美洲';

  @override
  String get continentOceania => '大洋洲';

  @override
  String currentOfTotal(int current, int total) {
    return '$current／$total';
  }

  @override
  String speechAlso(String variants) {
    return '亦作 $variants。';
  }

  @override
  String speechAsIn(String example) {
    return '例如：$example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '源自$origin，$originWord。';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form，意為 $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return '淺白來說：$friendly';
  }

  @override
  String get categorySpeech => '言語與修辭';

  @override
  String get categoryCharacter => '性格與氣質';

  @override
  String get categoryCriticism => '批評與辱罵';

  @override
  String get categoryVirtue => '美德';

  @override
  String get categoryVice => '惡德';

  @override
  String get categoryKnowledge => '知識與思想';

  @override
  String get categoryReligion => '宗教與精神';

  @override
  String get categoryBeginnings => '開端';

  @override
  String get categoryConflict => '衝突與欺瞞';

  @override
  String get categoryAppearance => '外表與光';

  @override
  String get categoryPeople => '人物與角色';

  @override
  String get categoryObjects => '物件與事物';

  @override
  String get categoryEmotion => '情感';

  @override
  String get categoryArchaic => '古語與舊詞';

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

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class AppLocalizationsZhHk extends AppLocalizationsZh {
  AppLocalizationsZhHk() : super('zh_HK');

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => '優美語言的詞彙集';

  @override
  String get navHome => '主頁';

  @override
  String get navLexicon => '詞彙集';

  @override
  String get navQuiz => '測驗';

  @override
  String get navSaved => '已儲存';

  @override
  String get navLanguages => '語言';

  @override
  String homeBlurb(int count, String lexicon) {
    return '來自$lexicon詞彙集的$count個罕有而豐厚的詞——像朋友解說，而不是字典。';
  }

  @override
  String wordsExplored(int current, int total) {
    return '已閱覽 $current／$total 個詞';
  }

  @override
  String get exploreLexicon => '瀏覽詞彙集';

  @override
  String get startQuiz => '開始測驗';

  @override
  String get wordOfTheDay => '今日一字';

  @override
  String get readFullEntry => '閱讀全文 →';

  @override
  String get lexiconTitle => '詞彙集';

  @override
  String get lexiconCaption => '匯集';

  @override
  String get savedTitle => '已儲存的詞';

  @override
  String get savedCaption => '收藏近身';

  @override
  String get searchHint => '搜尋一個詞，或描述其意思…';

  @override
  String get clearSearch => '清除搜尋';

  @override
  String get filterAll => '全部';

  @override
  String get noMatches => '尚未有結果——試試另一個詞或感覺。';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n 個結果',
      one: '1 個結果',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => '這裏什麼也沒有';

  @override
  String get emptyLexicon => '詞彙集這一角空無一物。';

  @override
  String get emptySaved => '尚未儲存任何詞。在任何條目輕觸心形。';

  @override
  String get tapToReadMore => '輕觸以閱讀更多';

  @override
  String get saveWord => '儲存詞語';

  @override
  String get removeFromFavorites => '從收藏移除';

  @override
  String get inPlainWords => '淺白來說';

  @override
  String get theDefinition => '定義';

  @override
  String get inASentence => '句中';

  @override
  String get exampleGlossLabel => '換言之';

  @override
  String get save => '儲存';

  @override
  String get saved => '已儲存';

  @override
  String get copy => '複製';

  @override
  String get copiedToClipboard => '已複製到剪貼簿';

  @override
  String get roots => '詞根';

  @override
  String get quizTitle => '一小道測驗';

  @override
  String get quizCaption => '先識詞根，再選意思';

  @override
  String get quizIntro => '每題顯示一個詞及其語源。選出合適的定義——四個選擇，一個正確。';

  @override
  String get howManyWords => '多少個詞';

  @override
  String get begin => '開始';

  @override
  String get quizByTheme => '按主題測驗';

  @override
  String get endQuiz => '結束測驗';

  @override
  String questionOf(int index, int length) {
    return '第 $index 題／共 $length 題';
  }

  @override
  String get whichDefinitionFits => '哪個定義合適？';

  @override
  String get previous => '上一題';

  @override
  String get next => '下一題';

  @override
  String get seeResults => '查看成績';

  @override
  String get themeTitle => '主題';

  @override
  String get chooseASubject => '選一個題目';

  @override
  String get noThemesYet => '尚未有主題。';

  @override
  String get notEnoughWordsInTheme => '這個主題尚未有足夠的詞。';

  @override
  String get results => '成績';

  @override
  String get perfectPage => '完美的一頁';

  @override
  String get wellMarked => '標記得宜';

  @override
  String get tryAnotherRound => '再試一回';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '答對 $score 個定義',
      one: '答對 1 個定義',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '共 $total 題，答對 $score 個定義。',
      one: '共 $total 題，答對一個定義。',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => '切換至淺色模式';

  @override
  String get switchToDarkMode => '切換至深色模式';

  @override
  String get listen => '聆聽';

  @override
  String get stop => '停止';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => '語言';

  @override
  String get languagesCaption => '眾舌';

  @override
  String get searchLanguages => '搜尋國家或語言…';

  @override
  String get noMatchingLanguages => '沒有相符的國家或語言。';

  @override
  String get selectedLanguage => '閱讀語言';

  @override
  String get continentAfrica => '非洲';

  @override
  String get continentAsia => '亞洲';

  @override
  String get continentEurope => '歐洲';

  @override
  String get continentAmericas => '美洲';

  @override
  String get continentOceania => '大洋洲';

  @override
  String currentOfTotal(int current, int total) {
    return '$current／$total';
  }

  @override
  String speechAlso(String variants) {
    return '亦作 $variants。';
  }

  @override
  String speechAsIn(String example) {
    return '例如：$example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '源自$origin，$originWord。';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form，意為 $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return '淺白來說：$friendly';
  }

  @override
  String get categorySpeech => '言語與修辭';

  @override
  String get categoryCharacter => '性格與氣質';

  @override
  String get categoryCriticism => '批評與辱罵';

  @override
  String get categoryVirtue => '美德';

  @override
  String get categoryVice => '惡德';

  @override
  String get categoryKnowledge => '知識與思想';

  @override
  String get categoryReligion => '宗教與精神';

  @override
  String get categoryBeginnings => '開端';

  @override
  String get categoryConflict => '衝突與欺瞞';

  @override
  String get categoryAppearance => '外表與光';

  @override
  String get categoryPeople => '人物與角色';

  @override
  String get categoryObjects => '物件與事物';

  @override
  String get categoryEmotion => '情感';

  @override
  String get categoryArchaic => '古語與舊詞';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => '優美語言的詞彙集';

  @override
  String get navHome => '首頁';

  @override
  String get navLexicon => '詞彙集';

  @override
  String get navQuiz => '測驗';

  @override
  String get navSaved => '已儲存';

  @override
  String get navLanguages => '語言';

  @override
  String homeBlurb(int count, String lexicon) {
    return '來自$lexicon詞彙集的$count個罕見而豐美的詞——像朋友解說，而不是字典。';
  }

  @override
  String wordsExplored(int current, int total) {
    return '已閱覽 $current／$total 個詞';
  }

  @override
  String get exploreLexicon => '瀏覽詞彙集';

  @override
  String get startQuiz => '開始測驗';

  @override
  String get wordOfTheDay => '今日一字';

  @override
  String get readFullEntry => '閱讀全文 →';

  @override
  String get lexiconTitle => '詞彙集';

  @override
  String get lexiconCaption => '匯集';

  @override
  String get savedTitle => '已儲存的詞';

  @override
  String get savedCaption => '收藏近身';

  @override
  String get searchHint => '搜尋一個詞，或描述它的意思…';

  @override
  String get clearSearch => '清除搜尋';

  @override
  String get filterAll => '全部';

  @override
  String get noMatches => '尚無結果——試試另一個詞或感覺。';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n 個結果',
      one: '1 個結果',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => '這裡什麼也沒有';

  @override
  String get emptyLexicon => '詞彙集這一角空無一物。';

  @override
  String get emptySaved => '尚未儲存任何詞。在任何條目輕觸愛心。';

  @override
  String get tapToReadMore => '輕觸以閱讀更多';

  @override
  String get saveWord => '儲存詞語';

  @override
  String get removeFromFavorites => '從收藏移除';

  @override
  String get inPlainWords => '淺白來說';

  @override
  String get theDefinition => '定義';

  @override
  String get inASentence => '句中';

  @override
  String get exampleGlossLabel => '換言之';

  @override
  String get save => '儲存';

  @override
  String get saved => '已儲存';

  @override
  String get copy => '複製';

  @override
  String get copiedToClipboard => '已複製到剪貼簿';

  @override
  String get roots => '詞根';

  @override
  String get quizTitle => '一小道測驗';

  @override
  String get quizCaption => '先識詞根，再選意思';

  @override
  String get quizIntro => '每題顯示一個詞及其語源。選出合適的定義——四個選擇，一個正確。';

  @override
  String get howManyWords => '多少個詞';

  @override
  String get begin => '開始';

  @override
  String get quizByTheme => '依主題測驗';

  @override
  String get endQuiz => '結束測驗';

  @override
  String questionOf(int index, int length) {
    return '第 $index 題／共 $length 題';
  }

  @override
  String get whichDefinitionFits => '哪個定義合適？';

  @override
  String get previous => '上一題';

  @override
  String get next => '下一題';

  @override
  String get seeResults => '查看成績';

  @override
  String get themeTitle => '主題';

  @override
  String get chooseASubject => '選一個題目';

  @override
  String get noThemesYet => '尚無主題。';

  @override
  String get notEnoughWordsInTheme => '這個主題尚無足夠的詞。';

  @override
  String get results => '成績';

  @override
  String get perfectPage => '完美的一頁';

  @override
  String get wellMarked => '標記得宜';

  @override
  String get tryAnotherRound => '再試一回';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '答對 $score 個定義',
      one: '答對 1 個定義',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '共 $total 題，答對 $score 個定義。',
      one: '共 $total 題，答對一個定義。',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => '切換至淺色模式';

  @override
  String get switchToDarkMode => '切換至深色模式';

  @override
  String get listen => '聆聽';

  @override
  String get stop => '停止';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => '語言';

  @override
  String get languagesCaption => '眾舌';

  @override
  String get searchLanguages => '搜尋國家或語言…';

  @override
  String get noMatchingLanguages => '沒有相符的國家或語言。';

  @override
  String get selectedLanguage => '閱讀語言';

  @override
  String get continentAfrica => '非洲';

  @override
  String get continentAsia => '亞洲';

  @override
  String get continentEurope => '歐洲';

  @override
  String get continentAmericas => '美洲';

  @override
  String get continentOceania => '大洋洲';

  @override
  String currentOfTotal(int current, int total) {
    return '$current／$total';
  }

  @override
  String speechAlso(String variants) {
    return '亦作 $variants。';
  }

  @override
  String speechAsIn(String example) {
    return '例如：$example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '源自$origin，$originWord。';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form，意為 $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return '淺白來說：$friendly';
  }

  @override
  String get categorySpeech => '言語與修辭';

  @override
  String get categoryCharacter => '性格與氣質';

  @override
  String get categoryCriticism => '批評與辱罵';

  @override
  String get categoryVirtue => '美德';

  @override
  String get categoryVice => '惡德';

  @override
  String get categoryKnowledge => '知識與思想';

  @override
  String get categoryReligion => '宗教與精神';

  @override
  String get categoryBeginnings => '開端';

  @override
  String get categoryConflict => '衝突與欺瞞';

  @override
  String get categoryAppearance => '外表與光';

  @override
  String get categoryPeople => '人物與角色';

  @override
  String get categoryObjects => '物件與事物';

  @override
  String get categoryEmotion => '情感';

  @override
  String get categoryArchaic => '古語與舊詞';
}
