// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'một từ điển ngôn ngữ đẹp';

  @override
  String get navHome => 'Trang chủ';

  @override
  String get navLexicon => 'Từ điển';

  @override
  String get navQuiz => 'Đố vui';

  @override
  String get navSaved => 'Đã lưu';

  @override
  String get navLanguages => 'Ngôn ngữ';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count từ hiếm và phong phú từ từ điển $lexicon — được giải thích như một người bạn, không phải như từ điển.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'đã xem $current trên $total từ';
  }

  @override
  String get exploreLexicon => 'Khám phá từ điển';

  @override
  String get startQuiz => 'Bắt đầu đố vui';

  @override
  String get wordOfTheDay => 'từ của ngày';

  @override
  String get readFullEntry => 'Đọc toàn bộ mục →';

  @override
  String get lexiconTitle => 'Từ điển';

  @override
  String get lexiconCaption => 'tập hợp';

  @override
  String get savedTitle => 'Từ đã lưu';

  @override
  String get savedCaption => 'giữ gần';

  @override
  String get searchHint => 'Tìm một từ, hoặc mô tả nghĩa của nó…';

  @override
  String get clearSearch => 'Xóa tìm kiếm';

  @override
  String get filterAll => 'Tất cả';

  @override
  String get noMatches => 'Chưa có kết quả — thử từ hoặc cảm giác khác.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n kết quả',
      one: '1 kết quả',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'không có gì ở đây';

  @override
  String get emptyLexicon => 'Không có gì ở góc này của từ điển.';

  @override
  String get emptySaved =>
      'Chưa có từ đã lưu. Chạm trái tim trên bất kỳ mục nào.';

  @override
  String get tapToReadMore => 'Chạm để đọc thêm';

  @override
  String get saveWord => 'Lưu từ';

  @override
  String get removeFromFavorites => 'Xóa khỏi yêu thích';

  @override
  String get inPlainWords => 'bằng lời giản dị';

  @override
  String get theDefinition => 'định nghĩa';

  @override
  String get inASentence => 'trong một câu';

  @override
  String get exampleGlossLabel => 'nói cách khác';

  @override
  String get save => 'Lưu';

  @override
  String get saved => 'Đã lưu';

  @override
  String get copy => 'Sao chép';

  @override
  String get copiedToClipboard => 'Đã sao chép vào bộ nhớ tạm';

  @override
  String get roots => 'gốc';

  @override
  String get quizTitle => 'Một đố vui nhỏ';

  @override
  String get quizCaption => 'biết gốc, rồi chọn nghĩa';

  @override
  String get quizIntro =>
      'Mỗi câu hiện một từ và nguồn gốc của nó. Chọn định nghĩa vừa khớp — bốn lựa chọn, một đúng.';

  @override
  String get howManyWords => 'bao nhiêu từ';

  @override
  String get begin => 'Bắt đầu';

  @override
  String get quizByTheme => 'Đố vui theo chủ đề';

  @override
  String get endQuiz => 'Kết thúc đố vui';

  @override
  String questionOf(int index, int length) {
    return 'Câu $index trên $length';
  }

  @override
  String get whichDefinitionFits => 'định nghĩa nào vừa?';

  @override
  String get previous => 'Trước';

  @override
  String get next => 'Tiếp';

  @override
  String get seeResults => 'Xem kết quả';

  @override
  String get themeTitle => 'Chủ đề';

  @override
  String get chooseASubject => 'chọn một đề tài';

  @override
  String get noThemesYet => 'Chưa có chủ đề.';

  @override
  String get notEnoughWordsInTheme => 'Chủ đề này chưa đủ từ.';

  @override
  String get results => 'Kết quả';

  @override
  String get perfectPage => 'một trang hoàn hảo';

  @override
  String get wellMarked => 'đánh dấu khéo';

  @override
  String get tryAnotherRound => 'Thử vòng khác';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score định nghĩa đúng',
      one: '1 định nghĩa đúng',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score định nghĩa đúng, trên $total.',
      one: 'Một định nghĩa đúng, trên $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Chuyển sang chế độ sáng';

  @override
  String get switchToDarkMode => 'Chuyển sang chế độ tối';

  @override
  String get listen => 'Nghe';

  @override
  String get stop => 'Dừng';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Ngôn ngữ';

  @override
  String get languagesCaption => 'các tiếng';

  @override
  String get searchLanguages => 'Tìm quốc gia hoặc ngôn ngữ…';

  @override
  String get noMatchingLanguages => 'Không có quốc gia hay ngôn ngữ khớp.';

  @override
  String get selectedLanguage => 'Đang đọc bằng';

  @override
  String get continentAfrica => 'Châu Phi';

  @override
  String get continentAsia => 'Châu Á';

  @override
  String get continentEurope => 'Châu Âu';

  @override
  String get continentAmericas => 'Châu Mỹ';

  @override
  String get continentOceania => 'Châu Đại Dương';

  @override
  String currentOfTotal(int current, int total) {
    return '$current trên $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Cũng $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Như trong: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Từ $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, nghĩa $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Bằng lời giản dị: $friendly';
  }

  @override
  String get categorySpeech => 'Lời nói và tu từ';

  @override
  String get categoryCharacter => 'Tính cách và khí chất';

  @override
  String get categoryCriticism => 'Phê bình và xúc phạm';

  @override
  String get categoryVirtue => 'Đức hạnh';

  @override
  String get categoryVice => 'Tật xấu';

  @override
  String get categoryKnowledge => 'Tri thức và tư tưởng';

  @override
  String get categoryReligion => 'Tôn giáo và tinh thần';

  @override
  String get categoryBeginnings => 'Khởi đầu';

  @override
  String get categoryConflict => 'Xung đột và dối trá';

  @override
  String get categoryAppearance => 'Dáng vẻ và ánh sáng';

  @override
  String get categoryPeople => 'Người và vai trò';

  @override
  String get categoryObjects => 'Vật và đồ vật';

  @override
  String get categoryEmotion => 'Cảm xúc';

  @override
  String get categoryArchaic => 'Cổ và cổ kính';
}
