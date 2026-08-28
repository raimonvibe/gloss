// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'leksikon bahasa yang indah';

  @override
  String get navHome => 'Beranda';

  @override
  String get navLexicon => 'Leksikon';

  @override
  String get navQuiz => 'Kuis';

  @override
  String get navSaved => 'Tersimpan';

  @override
  String get navLanguages => 'Bahasa';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count kata langka dan kaya dari leksikon $lexicon — dijelaskan seperti teman, bukan kamus.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current dari $total kata dijelajahi';
  }

  @override
  String get exploreLexicon => 'Jelajahi leksikon';

  @override
  String get startQuiz => 'Mulai kuis';

  @override
  String get wordOfTheDay => 'kata hari ini';

  @override
  String get readFullEntry => 'Baca entri lengkap →';

  @override
  String get lexiconTitle => 'Leksikon';

  @override
  String get lexiconCaption => 'kumpulan';

  @override
  String get savedTitle => 'Kata tersimpan';

  @override
  String get savedCaption => 'di dekat hati';

  @override
  String get searchHint => 'Cari kata, atau uraikan maknanya…';

  @override
  String get clearSearch => 'Hapus pencarian';

  @override
  String get filterAll => 'Semua';

  @override
  String get noMatches => 'Belum ada yang cocok — coba kata atau rasa lain.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n kecocokan',
      one: '1 kecocokan',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'tidak ada di sini';

  @override
  String get emptyLexicon => 'Tidak ada di sudut leksikon ini.';

  @override
  String get emptySaved =>
      'Belum ada kata tersimpan. Ketuk hati pada entri mana pun.';

  @override
  String get tapToReadMore => 'Ketuk untuk membaca lebih lanjut';

  @override
  String get saveWord => 'Simpan kata';

  @override
  String get removeFromFavorites => 'Hapus dari favorit';

  @override
  String get inPlainWords => 'dengan kata sederhana';

  @override
  String get theDefinition => 'definisi';

  @override
  String get inASentence => 'dalam sebuah kalimat';

  @override
  String get exampleGlossLabel => 'dengan kata lain';

  @override
  String get save => 'Simpan';

  @override
  String get saved => 'Tersimpan';

  @override
  String get copy => 'Salin';

  @override
  String get copiedToClipboard => 'Disalin ke papan klip';

  @override
  String get roots => 'akar';

  @override
  String get quizTitle => 'Kuis kecil';

  @override
  String get quizCaption => 'kenali akarnya, lalu pilih makna';

  @override
  String get quizIntro =>
      'Setiap pertanyaan menampilkan kata dan etimologinya. Pilih definisi yang cocok — empat pilihan, satu yang benar.';

  @override
  String get howManyWords => 'berapa kata';

  @override
  String get begin => 'Mulai';

  @override
  String get quizByTheme => 'Kuis menurut tema';

  @override
  String get endQuiz => 'Akhiri kuis';

  @override
  String questionOf(int index, int length) {
    return 'Pertanyaan $index dari $length';
  }

  @override
  String get whichDefinitionFits => 'definisi mana yang cocok?';

  @override
  String get previous => 'Sebelumnya';

  @override
  String get next => 'Berikutnya';

  @override
  String get seeResults => 'Lihat hasil';

  @override
  String get themeTitle => 'Tema';

  @override
  String get chooseASubject => 'pilih pokok';

  @override
  String get noThemesYet => 'Belum ada tema.';

  @override
  String get notEnoughWordsInTheme => 'Belum cukup kata dalam tema ini.';

  @override
  String get results => 'Hasil';

  @override
  String get perfectPage => 'halaman yang sempurna';

  @override
  String get wellMarked => 'tertandai indah';

  @override
  String get tryAnotherRound => 'Coba ronde lain';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definisi benar',
      one: '1 definisi benar',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definisi benar, dari $total.',
      one: 'Satu definisi benar, dari $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Beralih ke mode terang';

  @override
  String get switchToDarkMode => 'Beralih ke mode gelap';

  @override
  String get listen => 'Dengar';

  @override
  String get stop => 'Berhenti';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Bahasa';

  @override
  String get languagesCaption => 'lidah-lidah';

  @override
  String get searchLanguages => 'Cari negara atau bahasa…';

  @override
  String get noMatchingLanguages => 'Tidak ada negara atau bahasa yang cocok.';

  @override
  String get selectedLanguage => 'Membaca dalam';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Asia';

  @override
  String get continentEurope => 'Eropa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Oseania';

  @override
  String currentOfTotal(int current, int total) {
    return '$current dari $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Juga $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Seperti dalam: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Dari $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, makna $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Dengan kata sederhana: $friendly';
  }

  @override
  String get categorySpeech => 'Tutur & retorika';

  @override
  String get categoryCharacter => 'Watak & temperamen';

  @override
  String get categoryCriticism => 'Kritik & hinaan';

  @override
  String get categoryVirtue => 'Kebajikan';

  @override
  String get categoryVice => 'Keburukan';

  @override
  String get categoryKnowledge => 'Pengetahuan & pikiran';

  @override
  String get categoryReligion => 'Agama & roh';

  @override
  String get categoryBeginnings => 'Awal mula';

  @override
  String get categoryConflict => 'Konflik & tipu daya';

  @override
  String get categoryAppearance => 'Penampilan & cahaya';

  @override
  String get categoryPeople => 'Orang & peran';

  @override
  String get categoryObjects => 'Benda & barang';

  @override
  String get categoryEmotion => 'Emosi';

  @override
  String get categoryArchaic => 'Lama & arkais';
}
