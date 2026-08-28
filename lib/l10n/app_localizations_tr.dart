// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'güzel dilin sözlüğü';

  @override
  String get navHome => 'Ana sayfa';

  @override
  String get navLexicon => 'Sözlük';

  @override
  String get navQuiz => 'Sınav';

  @override
  String get navSaved => 'Kaydedilenler';

  @override
  String get navLanguages => 'Diller';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$lexicon sözlüğünden $count nadir, zengin sözcük — sözlük gibi değil, bir dostun anlatacağı gibi.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$total sözcükten $current tanesi keşfedildi';
  }

  @override
  String get exploreLexicon => 'Sözlüğü keşfet';

  @override
  String get startQuiz => 'Sınava başla';

  @override
  String get wordOfTheDay => 'günün sözcüğü';

  @override
  String get readFullEntry => 'Tüm maddeyi oku →';

  @override
  String get lexiconTitle => 'Sözlük';

  @override
  String get lexiconCaption => 'derleme';

  @override
  String get savedTitle => 'Kaydedilen sözcükler';

  @override
  String get savedCaption => 'yakında tutulanlar';

  @override
  String get searchHint => 'Bir sözcük ara ya da anlamını betimle…';

  @override
  String get clearSearch => 'Aramayı temizle';

  @override
  String get filterAll => 'Tümü';

  @override
  String get noMatches =>
      'Henüz eşleşme yok — başka bir sözcük veya duygu dene.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n eşleşme',
      one: '1 eşleşme',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'burada hiçbir şey yok';

  @override
  String get emptyLexicon => 'Sözlüğün bu köşesinde hiçbir şey yok.';

  @override
  String get emptySaved =>
      'Henüz kaydedilmiş sözcük yok. Herhangi bir maddede kalbe dokun.';

  @override
  String get tapToReadMore => 'Daha fazlasını okumak için dokun';

  @override
  String get saveWord => 'Sözcüğü kaydet';

  @override
  String get removeFromFavorites => 'Favorilerden çıkar';

  @override
  String get inPlainWords => 'yalın sözlerle';

  @override
  String get theDefinition => 'tanım';

  @override
  String get inASentence => 'bir cümlede';

  @override
  String get exampleGlossLabel => 'başka deyişle';

  @override
  String get save => 'Kaydet';

  @override
  String get saved => 'Kaydedildi';

  @override
  String get copy => 'Kopyala';

  @override
  String get copiedToClipboard => 'Panoya kopyalandı';

  @override
  String get roots => 'kökler';

  @override
  String get quizTitle => 'Küçük bir sınav';

  @override
  String get quizCaption => 'kökleri öğren, sonra anlamı seç';

  @override
  String get quizIntro =>
      'Her soru bir sözcük ve etimolojisini gösterir. Uyan tanımı seç — dört seçenek, biri doğru.';

  @override
  String get howManyWords => 'kaç sözcük';

  @override
  String get begin => 'Başla';

  @override
  String get quizByTheme => 'Konuya göre sınav';

  @override
  String get endQuiz => 'Sınavı bitir';

  @override
  String questionOf(int index, int length) {
    return 'Soru $index / $length';
  }

  @override
  String get whichDefinitionFits => 'hangi tanım uyuyor?';

  @override
  String get previous => 'Önceki';

  @override
  String get next => 'Sonraki';

  @override
  String get seeResults => 'Sonuçları gör';

  @override
  String get themeTitle => 'Konu';

  @override
  String get chooseASubject => 'bir konu seç';

  @override
  String get noThemesYet => 'Henüz konu yok.';

  @override
  String get notEnoughWordsInTheme => 'Bu konuda henüz yeterince sözcük yok.';

  @override
  String get results => 'Sonuçlar';

  @override
  String get perfectPage => 'kusursuz bir sayfa';

  @override
  String get wellMarked => 'güzel işaretlenmiş';

  @override
  String get tryAnotherRound => 'Başka bir tur dene';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score doğru tanım',
      one: '1 doğru tanım',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score doğru tanım, $total içinden.',
      one: 'Bir doğru tanım, $total içinden.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Açık kipe geç';

  @override
  String get switchToDarkMode => 'Koyu kipe geç';

  @override
  String get listen => 'Dinle';

  @override
  String get stop => 'Durdur';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Diller';

  @override
  String get languagesCaption => 'diller';

  @override
  String get searchLanguages => 'Ülke veya dil ara…';

  @override
  String get noMatchingLanguages => 'Eşleşen ülke veya dil yok.';

  @override
  String get selectedLanguage => 'Okuma dili';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Asya';

  @override
  String get continentEurope => 'Avrupa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Okyanusya';

  @override
  String currentOfTotal(int current, int total) {
    return '$current / $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Ayrıca $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Örneğin: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '$origin dilinden, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, anlamı $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Yalın sözlerle: $friendly';
  }

  @override
  String get categorySpeech => 'Söz ve belagat';

  @override
  String get categoryCharacter => 'Karakter ve mizaç';

  @override
  String get categoryCriticism => 'Eleştiri ve hakaret';

  @override
  String get categoryVirtue => 'Erdem';

  @override
  String get categoryVice => 'Kusur';

  @override
  String get categoryKnowledge => 'Bilgi ve düşünce';

  @override
  String get categoryReligion => 'Din ve ruh';

  @override
  String get categoryBeginnings => 'Başlangıçlar';

  @override
  String get categoryConflict => 'Çatışma ve aldatma';

  @override
  String get categoryAppearance => 'Görünüş ve ışık';

  @override
  String get categoryPeople => 'İnsanlar ve roller';

  @override
  String get categoryObjects => 'Nesneler ve şeyler';

  @override
  String get categoryEmotion => 'Duygu';

  @override
  String get categoryArchaic => 'Eski ve arkaik';
}
