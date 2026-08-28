// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'leksikon bahasa yang indah';

  @override
  String get navHome => 'Laman utama';

  @override
  String get navLexicon => 'Leksikon';

  @override
  String get navQuiz => 'Kuiz';

  @override
  String get navSaved => 'Disimpan';

  @override
  String get navLanguages => 'Bahasa';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count perkataan jarang dan kaya dari leksikon $lexicon — dijelaskan seperti kawan, bukan kamus.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current daripada $total perkataan dijelajahi';
  }

  @override
  String get exploreLexicon => 'Jelajahi leksikon';

  @override
  String get startQuiz => 'Mulakan kuiz';

  @override
  String get wordOfTheDay => 'perkataan hari ini';

  @override
  String get readFullEntry => 'Baca entri penuh →';

  @override
  String get lexiconTitle => 'Leksikon';

  @override
  String get lexiconCaption => 'kumpulan';

  @override
  String get savedTitle => 'Perkataan disimpan';

  @override
  String get savedCaption => 'dipegang rapat';

  @override
  String get searchHint => 'Cari perkataan, atau terangkan maknanya…';

  @override
  String get clearSearch => 'Kosongkan carian';

  @override
  String get filterAll => 'Semua';

  @override
  String get noMatches =>
      'Belum ada padanan — cuba perkataan atau perasaan lain.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n padanan',
      one: '1 padanan',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'tiada di sini';

  @override
  String get emptyLexicon => 'Tiada apa-apa di sudut leksikon ini.';

  @override
  String get emptySaved =>
      'Belum ada perkataan disimpan. Ketik hati pada mana-mana entri.';

  @override
  String get tapToReadMore => 'Ketik untuk membaca lagi';

  @override
  String get saveWord => 'Simpan perkataan';

  @override
  String get removeFromFavorites => 'Buang daripada kegemaran';

  @override
  String get inPlainWords => 'dengan kata mudah';

  @override
  String get theDefinition => 'takrifan';

  @override
  String get inASentence => 'dalam ayat';

  @override
  String get exampleGlossLabel => 'dengan kata lain';

  @override
  String get save => 'Simpan';

  @override
  String get saved => 'Disimpan';

  @override
  String get copy => 'Salin';

  @override
  String get copiedToClipboard => 'Disalin ke papan klip';

  @override
  String get roots => 'akar';

  @override
  String get quizTitle => 'Kuiz kecil';

  @override
  String get quizCaption => 'kenali akar, kemudian pilih makna';

  @override
  String get quizIntro =>
      'Setiap soalan menunjukkan perkataan dan etimologinya. Pilih takrifan yang sesuai — empat pilihan, satu benar.';

  @override
  String get howManyWords => 'berapa perkataan';

  @override
  String get begin => 'Mula';

  @override
  String get quizByTheme => 'Kuiz mengikut tema';

  @override
  String get endQuiz => 'Tamatkan kuiz';

  @override
  String questionOf(int index, int length) {
    return 'Soalan $index daripada $length';
  }

  @override
  String get whichDefinitionFits => 'takrifan mana yang sesuai?';

  @override
  String get previous => 'Sebelum';

  @override
  String get next => 'Seterusnya';

  @override
  String get seeResults => 'Lihat keputusan';

  @override
  String get themeTitle => 'Tema';

  @override
  String get chooseASubject => 'pilih subjek';

  @override
  String get noThemesYet => 'Belum ada tema.';

  @override
  String get notEnoughWordsInTheme => 'Belum cukup perkataan dalam tema ini.';

  @override
  String get results => 'Keputusan';

  @override
  String get perfectPage => 'halaman yang sempurna';

  @override
  String get wellMarked => 'ditandai indah';

  @override
  String get tryAnotherRound => 'Cuba pusingan lain';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score takrifan betul',
      one: '1 takrifan betul',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score takrifan betul, daripada $total.',
      one: 'Satu takrifan betul, daripada $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Tukar ke mod cerah';

  @override
  String get switchToDarkMode => 'Tukar ke mod gelap';

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
  String get noMatchingLanguages => 'Tiada negara atau bahasa yang sepadan.';

  @override
  String get selectedLanguage => 'Membaca dalam';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Asia';

  @override
  String get continentEurope => 'Eropah';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Oceania';

  @override
  String currentOfTotal(int current, int total) {
    return '$current daripada $total';
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
    return 'Daripada $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, maksud $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Dengan kata mudah: $friendly';
  }

  @override
  String get categorySpeech => 'Tutur & retorik';

  @override
  String get categoryCharacter => 'Watak & temperamen';

  @override
  String get categoryCriticism => 'Kritik & nista';

  @override
  String get categoryVirtue => 'Kebajikan';

  @override
  String get categoryVice => 'Keburukan';

  @override
  String get categoryKnowledge => 'Ilmu & fikiran';

  @override
  String get categoryReligion => 'Agama & roh';

  @override
  String get categoryBeginnings => 'Permulaan';

  @override
  String get categoryConflict => 'Konflik & tipu daya';

  @override
  String get categoryAppearance => 'Rupa & cahaya';

  @override
  String get categoryPeople => 'Orang & peranan';

  @override
  String get categoryObjects => 'Benda & barang';

  @override
  String get categoryEmotion => 'Emosi';

  @override
  String get categoryArchaic => 'Lama & arkais';

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
