import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocaleInfo {
  const LocaleInfo({
    required this.id,
    required this.translationKey,
    required this.languageCode,
    required this.languageNameEn,
    required this.languageNameNative,
    required this.rtl,
    this.countryCode,
  });

  final String id;
  final String translationKey;
  final String languageCode;
  final String? countryCode;
  final String languageNameEn;
  final String languageNameNative;
  final bool rtl;

  Locale get flutterLocale {
    if (countryCode == null || countryCode!.isEmpty) {
      return Locale(languageCode);
    }
    return Locale.fromSubtags(
      languageCode: languageCode,
      countryCode: countryCode,
    );
  }

  factory LocaleInfo.fromJson(Map<String, dynamic> json) {
    return LocaleInfo(
      id: json['id'] as String,
      translationKey: json['translationKey'] as String,
      languageCode: json['languageCode'] as String,
      countryCode: json['countryCode'] as String?,
      languageNameEn: json['languageNameEn'] as String,
      languageNameNative: json['languageNameNative'] as String,
      rtl: json['rtl'] as bool? ?? false,
    );
  }
}

class CountryEntry {
  const CountryEntry({
    required this.name,
    required this.iso2,
    required this.flag,
    required this.continent,
    required this.localeIds,
  });

  final String name;
  final String iso2;
  final String flag;
  final String continent;
  final List<String> localeIds;

  factory CountryEntry.fromJson(Map<String, dynamic> json) {
    return CountryEntry(
      name: json['name'] as String,
      iso2: json['iso2'] as String,
      flag: json['flag'] as String,
      continent: json['continent'] as String,
      localeIds: (json['localeIds'] as List<dynamic>).cast<String>(),
    );
  }
}

class LanguageChoice {
  const LanguageChoice({
    required this.country,
    required this.locale,
  });

  final CountryEntry country;
  final LocaleInfo locale;

  String get id => '${country.iso2}:${locale.id}';

  String get searchHaystack => [
        country.name,
        country.iso2,
        country.continent,
        locale.id,
        locale.languageNameEn,
        locale.languageNameNative,
        locale.languageCode,
      ].join(' ').toLowerCase();
}

class LocaleCatalog {
  LocaleCatalog._(this.countries, this.locales)
      : byId = {for (final locale in locales) locale.id: locale};

  final List<CountryEntry> countries;
  final List<LocaleInfo> locales;
  final Map<String, LocaleInfo> byId;

  static const assetPath = 'l10n/catalog.json';

  static Future<LocaleCatalog> load({AssetBundle? bundle}) async {
    final raw = await (bundle ?? rootBundle).loadString(assetPath);
    return LocaleCatalog.fromJsonString(raw);
  }

  factory LocaleCatalog.fromJsonString(String raw) {
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final countries = (decoded['countries'] as List<dynamic>)
        .map((e) => CountryEntry.fromJson(e as Map<String, dynamic>))
        .toList();
    final locales = (decoded['locales'] as List<dynamic>)
        .map((e) => LocaleInfo.fromJson(e as Map<String, dynamic>))
        .toList();
    return LocaleCatalog._(countries, locales);
  }

  static final englishOnly = LocaleCatalog._(
    const [
      CountryEntry(
        name: 'United States',
        iso2: 'US',
        flag: '🇺🇸',
        continent: 'Americas',
        localeIds: ['en-US'],
      ),
    ],
    const [
      LocaleInfo(
        id: 'en-US',
        translationKey: 'en',
        languageCode: 'en',
        countryCode: 'US',
        languageNameEn: 'English',
        languageNameNative: 'English',
        rtl: false,
      ),
    ],
  );

  List<LanguageChoice> get choices {
    final rows = <LanguageChoice>[];
    for (final country in countries) {
      for (final localeId in country.localeIds) {
        final locale = byId[localeId];
        if (locale == null) continue;
        rows.add(LanguageChoice(country: country, locale: locale));
      }
    }
    return rows;
  }

  List<Locale> get supportedLocales {
    final seen = <String>{};
    final out = <Locale>[];
    for (final locale in locales) {
      final key = locale.flutterLocale.toLanguageTag();
      if (!seen.add(key)) continue;
      out.add(locale.flutterLocale);
    }
    return out;
  }

  LocaleInfo? infoFor(String localeId) => byId[localeId];

  String translationKeyFor(String localeId) {
    return byId[localeId]?.translationKey ?? 'en';
  }

  bool isRtl(String localeId) => byId[localeId]?.rtl ?? false;

  LanguageChoice? choiceForLocale(String localeId) {
    for (final choice in choices) {
      if (choice.locale.id == localeId) return choice;
    }
    return null;
  }

  String matchDevice(List<Locale> devices) {
    for (final device in devices) {
      final language = _canonicalizeLanguage(device.languageCode);
      final country = device.countryCode;
      if (country != null && country.isNotEmpty) {
        final exact = '$language-$country';
        if (byId.containsKey(exact)) return exact;
        if (language == 'es' && country == 'US' && byId.containsKey('es-US')) {
          return 'es-US';
        }
      }
      for (final locale in locales) {
        if (locale.languageCode == language && locale.countryCode == country) {
          return locale.id;
        }
      }
    }
    for (final device in devices) {
      final language = _canonicalizeLanguage(device.languageCode);
      for (final locale in locales) {
        if (locale.languageCode == language) return locale.id;
      }
    }
    return 'en-US';
  }

  Locale resolve(
    String? savedId,
    List<Locale> devices,
  ) {
    if (savedId != null && byId.containsKey(savedId)) {
      return byId[savedId]!.flutterLocale;
    }
    return byId[matchDevice(devices)]?.flutterLocale ?? const Locale('en', 'US');
  }

  String resolvedId(String? savedId, List<Locale> devices) {
    if (savedId != null && byId.containsKey(savedId)) return savedId;
    return matchDevice(devices);
  }

  static String _canonicalizeLanguage(String code) {
    return switch (code) {
      'iw' => 'he',
      'no' => 'nb',
      'in' => 'id',
      'tl' => 'fil',
      _ => code,
    };
  }
}
