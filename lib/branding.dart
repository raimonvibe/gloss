/// User-facing names. The Dart package stays `beautiful_words`.
class Branding {
  static const displayName = 'Gloss';
  static const storeName = 'Gloss: Beautiful Words';
  static const lexiconName = 'Beautiful Words';
  static const tagline = 'a lexicon of lovely language';
  static const iconAsset = 'assets/images/app_icon.png';
  static const markAsset = 'assets/images/app_mark.png';

  /// Kept in step with `version:` in pubspec.yaml by a test, so the About
  /// section cannot quietly drift from what was shipped.
  static const version = '1.0.0';
  static const applicationId = 'com.raimonvibe.beautiful_words';
  static const storeUrl =
      'https://play.google.com/store/apps/details?id=$applicationId';
}
