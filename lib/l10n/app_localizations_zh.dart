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
  String get navStudy => '书房';

  @override
  String get studyTitle => '书房';

  @override
  String get studyCaption => '阅读、声音与光';

  @override
  String get readingSection => '阅读';

  @override
  String get readingCaption => '书页如何安放';

  @override
  String get textSize => '文字大小';

  @override
  String get textSizeSample => 'Edulcorate — 使之甘甜，使之柔和。';

  @override
  String get smaller => '更小';

  @override
  String get larger => '更大';

  @override
  String get autoplayPronunciation => '打开词条时朗读该词';

  @override
  String get reduceMotion => '让纹饰安静';

  @override
  String get reduceMotionCaption => '更少的花饰与渐变';

  @override
  String get voiceSection => '语音';

  @override
  String get voiceCaption => 'Gloss 如何朗读';

  @override
  String get chooseVoice => '语音';

  @override
  String get voiceDefault => '为你选定';

  @override
  String get noOtherVoices => '此设备未安装其他英语语音。';

  @override
  String get speechPace => '语速';

  @override
  String get slower => '更慢';

  @override
  String get faster => '更快';

  @override
  String get hearIt => '听一听';

  @override
  String get lightSection => '光';

  @override
  String get lightCaption => '羊皮纸或烛光';

  @override
  String get themeSystem => '跟随设备';

  @override
  String get themeLight => '羊皮纸';

  @override
  String get themeDark => '烛光';

  @override
  String get tongueSection => '语言';

  @override
  String get aboutSection => '关于';

  @override
  String get aboutCaption => '它是如何做成的';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => '开源许可';

  @override
  String get shareGloss => '分享 Gloss';

  @override
  String get followTheMaker => '关注作者';

  @override
  String couldNotOpenLink(String label) {
    return '无法打开 $label。';
  }

  @override
  String readExplanationsIn(String language) {
    return '以$language阅读释义';
  }

  @override
  String get readExplanationsCaption => '词语本身始终以英语朗读。';

  @override
  String noVoiceInstalled(String language) {
    return '此设备未安装 $language 语音。';
  }

  @override
  String get memorySection => '记忆';

  @override
  String get memoryCaption => 'Gloss 记住的东西';

  @override
  String get forgetProgress => '忘记我的进度';

  @override
  String get forgetProgressBody => '你读过的词将不再标记。收藏的词会保留。';

  @override
  String get clearSavedWords => '清空收藏的词';

  @override
  String get clearSavedWordsBody => '你收藏的词将被移除。你的进度会保留。';

  @override
  String get cancel => '取消';

  @override
  String get forget => '忘记';

  @override
  String get clear => '清空';

  @override
  String get progressForgotten => '进度已忘记。';

  @override
  String get savedWordsCleared => '收藏的词已清空。';
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

  @override
  String get navStudy => '書房';

  @override
  String get studyTitle => '書房';

  @override
  String get studyCaption => '閱讀、聲音與光';

  @override
  String get readingSection => '閱讀';

  @override
  String get readingCaption => '書頁如何安放';

  @override
  String get textSize => '文字大小';

  @override
  String get textSizeSample => 'Edulcorate — 使之甘甜，使之柔和。';

  @override
  String get smaller => '更小';

  @override
  String get larger => '更大';

  @override
  String get autoplayPronunciation => '開啟詞條時朗讀該詞';

  @override
  String get reduceMotion => '讓紋飾安靜';

  @override
  String get reduceMotionCaption => '更少花飾與漸變';

  @override
  String get voiceSection => '語音';

  @override
  String get voiceCaption => 'Gloss 如何朗讀';

  @override
  String get chooseVoice => '語音';

  @override
  String get voiceDefault => '為你選定';

  @override
  String get noOtherVoices => '此裝置未安裝其他英語語音。';

  @override
  String get speechPace => '語速';

  @override
  String get slower => '更慢';

  @override
  String get faster => '更快';

  @override
  String get hearIt => '聽一聽';

  @override
  String get lightSection => '光';

  @override
  String get lightCaption => '羊皮紙或燭光';

  @override
  String get themeSystem => '跟隨裝置';

  @override
  String get themeLight => '羊皮紙';

  @override
  String get themeDark => '燭光';

  @override
  String get tongueSection => '語言';

  @override
  String get aboutSection => '關於';

  @override
  String get aboutCaption => '它是怎樣造成的';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => '開源授權';

  @override
  String get shareGloss => '分享 Gloss';

  @override
  String get followTheMaker => '追蹤作者';

  @override
  String couldNotOpenLink(String label) {
    return '無法開啟 $label。';
  }

  @override
  String readExplanationsIn(String language) {
    return '以$language閱讀釋義';
  }

  @override
  String get readExplanationsCaption => '詞語本身一律以英語朗讀。';

  @override
  String noVoiceInstalled(String language) {
    return '此裝置未安裝 $language 語音。';
  }

  @override
  String get memorySection => '記憶';

  @override
  String get memoryCaption => 'Gloss 記住的東西';

  @override
  String get forgetProgress => '忘記我的進度';

  @override
  String get forgetProgressBody => '你讀過的詞將不再標記。收藏的詞會保留。';

  @override
  String get clearSavedWords => '清空收藏的詞';

  @override
  String get clearSavedWordsBody => '你收藏的詞將被移除。你的進度會保留。';

  @override
  String get cancel => '取消';

  @override
  String get forget => '忘記';

  @override
  String get clear => '清空';

  @override
  String get progressForgotten => '進度已忘記。';

  @override
  String get savedWordsCleared => '收藏的詞已清空。';
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

  @override
  String get navStudy => '書房';

  @override
  String get studyTitle => '書房';

  @override
  String get studyCaption => '閱讀、聲音與光';

  @override
  String get readingSection => '閱讀';

  @override
  String get readingCaption => '書頁如何安放';

  @override
  String get textSize => '文字大小';

  @override
  String get textSizeSample => 'Edulcorate — 使之甘甜，使之柔和。';

  @override
  String get smaller => '更小';

  @override
  String get larger => '更大';

  @override
  String get autoplayPronunciation => '開啟詞條時朗讀該詞';

  @override
  String get reduceMotion => '讓紋飾安靜';

  @override
  String get reduceMotionCaption => '更少花飾與漸層';

  @override
  String get voiceSection => '語音';

  @override
  String get voiceCaption => 'Gloss 如何朗讀';

  @override
  String get chooseVoice => '語音';

  @override
  String get voiceDefault => '為你選定';

  @override
  String get noOtherVoices => '這部裝置未安裝其他英語語音。';

  @override
  String get speechPace => '語速';

  @override
  String get slower => '更慢';

  @override
  String get faster => '更快';

  @override
  String get hearIt => '聽一聽';

  @override
  String get lightSection => '光';

  @override
  String get lightCaption => '羊皮紙或燭光';

  @override
  String get themeSystem => '跟隨裝置';

  @override
  String get themeLight => '羊皮紙';

  @override
  String get themeDark => '燭光';

  @override
  String get tongueSection => '語言';

  @override
  String get aboutSection => '關於';

  @override
  String get aboutCaption => '它是如何做成的';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => '開放原始碼授權';

  @override
  String get shareGloss => '分享 Gloss';

  @override
  String get followTheMaker => '追蹤作者';

  @override
  String couldNotOpenLink(String label) {
    return '無法開啟 $label。';
  }

  @override
  String readExplanationsIn(String language) {
    return '以$language閱讀釋義';
  }

  @override
  String get readExplanationsCaption => '詞語本身一律以英語朗讀。';

  @override
  String noVoiceInstalled(String language) {
    return '這部裝置未安裝 $language 語音。';
  }

  @override
  String get memorySection => '記憶';

  @override
  String get memoryCaption => 'Gloss 記住的東西';

  @override
  String get forgetProgress => '忘記我的進度';

  @override
  String get forgetProgressBody => '你讀過的詞將不再標記。收藏的詞會保留。';

  @override
  String get clearSavedWords => '清空收藏的詞';

  @override
  String get clearSavedWordsBody => '你收藏的詞將被移除。你的進度會保留。';

  @override
  String get cancel => '取消';

  @override
  String get forget => '忘記';

  @override
  String get clear => '清空';

  @override
  String get progressForgotten => '進度已忘記。';

  @override
  String get savedWordsCleared => '收藏的詞已清空。';
}
