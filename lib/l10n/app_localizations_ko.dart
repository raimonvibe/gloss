// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => '아름다운 말의 어휘집';

  @override
  String get navHome => '홈';

  @override
  String get navLexicon => '어휘집';

  @override
  String get navQuiz => '퀴즈';

  @override
  String get navSaved => '저장됨';

  @override
  String get navLanguages => '언어';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$lexicon 어휘집에서 온 $count개의 희귀하고 풍요로운 낱말 — 사전이 아니라 벗이 풀어 주듯 설명해 두었습니다.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$total개 중 $current개 낱말을 살펴봄';
  }

  @override
  String get exploreLexicon => '어휘집 둘러보기';

  @override
  String get startQuiz => '퀴즈 시작하기';

  @override
  String get wordOfTheDay => '오늘의 낱말';

  @override
  String get readFullEntry => '항목 전체 읽기 →';

  @override
  String get lexiconTitle => '어휘집';

  @override
  String get lexiconCaption => '모음';

  @override
  String get savedTitle => '저장한 낱말';

  @override
  String get savedCaption => '가까이 둔';

  @override
  String get searchHint => '낱말을 찾거나, 뜻을 적어 보세요…';

  @override
  String get clearSearch => '검색 지우기';

  @override
  String get filterAll => '모두';

  @override
  String get noMatches => '아직 맞는 것이 없습니다 — 다른 낱말이나 느낌을 시도해 보세요.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '일치 $n건',
      one: '일치 1건',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => '여기에는 아무것도 없습니다';

  @override
  String get emptyLexicon => '어휘집의 이 구석에는 아무것도 없습니다.';

  @override
  String get emptySaved => '아직 저장한 낱말이 없습니다. 항목의 하트를 누르세요.';

  @override
  String get tapToReadMore => '눌러서 더 읽기';

  @override
  String get saveWord => '낱말 저장';

  @override
  String get removeFromFavorites => '즐겨찾기에서 빼기';

  @override
  String get inPlainWords => '쉬운 말로';

  @override
  String get theDefinition => '정의';

  @override
  String get inASentence => '문장 속에서';

  @override
  String get exampleGlossLabel => '다른 말로';

  @override
  String get save => '저장';

  @override
  String get saved => '저장됨';

  @override
  String get copy => '복사';

  @override
  String get copiedToClipboard => '클립보드에 복사됨';

  @override
  String get roots => '어근';

  @override
  String get quizTitle => '작은 퀴즈';

  @override
  String get quizCaption => '어근을 알고, 뜻을 고르세요';

  @override
  String get quizIntro =>
      '각 문항은 낱말과 그 어원을 보여 줍니다. 들어맞는 정의를 고르세요 — 보기 넷, 참은 하나.';

  @override
  String get howManyWords => '몇 개의 낱말';

  @override
  String get begin => '시작';

  @override
  String get quizByTheme => '주제별 퀴즈';

  @override
  String get endQuiz => '퀴즈 마치기';

  @override
  String questionOf(int index, int length) {
    return '$index / $length번째 문제';
  }

  @override
  String get whichDefinitionFits => '어느 정의가 맞을까요?';

  @override
  String get previous => '이전';

  @override
  String get next => '다음';

  @override
  String get seeResults => '결과 보기';

  @override
  String get themeTitle => '주제';

  @override
  String get chooseASubject => '주제를 고르세요';

  @override
  String get noThemesYet => '아직 주제가 없습니다.';

  @override
  String get notEnoughWordsInTheme => '이 주제에는 아직 낱말이 충분하지 않습니다.';

  @override
  String get results => '결과';

  @override
  String get perfectPage => '완벽한 한 쪽';

  @override
  String get wellMarked => '곱게 표시됨';

  @override
  String get tryAnotherRound => '한 판 더';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '정의 $score개 정답',
      one: '정의 1개 정답',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$total개 중 정의 $score개 맞았습니다.',
      one: '$total개 중 정의 하나 맞았습니다.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => '밝은 모드로 전환';

  @override
  String get switchToDarkMode => '어두운 모드로 전환';

  @override
  String get listen => '듣기';

  @override
  String get stop => '멈추기';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => '언어';

  @override
  String get languagesCaption => '혀들';

  @override
  String get searchLanguages => '나라나 언어를 검색…';

  @override
  String get noMatchingLanguages => '맞는 나라나 언어가 없습니다.';

  @override
  String get selectedLanguage => '읽는 언어';

  @override
  String get continentAfrica => '아프리카';

  @override
  String get continentAsia => '아시아';

  @override
  String get continentEurope => '유럽';

  @override
  String get continentAmericas => '아메리카';

  @override
  String get continentOceania => '오세아니아';

  @override
  String currentOfTotal(int current, int total) {
    return '$current / $total';
  }

  @override
  String speechAlso(String variants) {
    return '또한 $variants.';
  }

  @override
  String speechAsIn(String example) {
    return '예: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '$origin의 $originWord에서.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, 뜻은 $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return '쉬운 말로: $friendly';
  }

  @override
  String get categorySpeech => '말과 수사';

  @override
  String get categoryCharacter => '성격과 기질';

  @override
  String get categoryCriticism => '비평과 모욕';

  @override
  String get categoryVirtue => '미덕';

  @override
  String get categoryVice => '악덕';

  @override
  String get categoryKnowledge => '지식과 사유';

  @override
  String get categoryReligion => '종교와 정신';

  @override
  String get categoryBeginnings => '시작';

  @override
  String get categoryConflict => '갈등과 기만';

  @override
  String get categoryAppearance => '겉모습과 빛';

  @override
  String get categoryPeople => '사람과 역할';

  @override
  String get categoryObjects => '사물과 물건';

  @override
  String get categoryEmotion => '감정';

  @override
  String get categoryArchaic => '옛말과 고어';
}
