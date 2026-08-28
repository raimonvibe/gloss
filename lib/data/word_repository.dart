import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/word_entry.dart';

const _stopwords = {
  'a',
  'an',
  'the',
  'of',
  'to',
  'in',
  'on',
  'for',
  'and',
  'or',
  'is',
  'its',
  'it',
  'as',
  'by',
  'with',
  'from',
  'that',
  'this',
  'be',
};

class WordRepository {
  WordRepository._(this.categories, this.words);

  final List<WordCategory> categories;
  final List<WordEntry> words;

  static Future<WordRepository> load({
    AssetBundle? bundle,
    String assetPath = 'assets/data/words.json',
  }) async {
    final raw = await (bundle ?? rootBundle).loadString(assetPath);
    return WordRepository.fromJsonString(raw);
  }

  factory WordRepository.fromJsonString(String raw) {
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final categories = (decoded['categories'] as List<dynamic>)
        .map((e) => WordCategory.fromJson(e as Map<String, dynamic>))
        .toList();
    final words = (decoded['words'] as List<dynamic>)
        .map((e) => WordEntry.fromJson(e as Map<String, dynamic>))
        .toList();
    return WordRepository._(categories, words);
  }

  String labelForTag(String id) {
    return categories
        .firstWhere(
          (c) => c.id == id,
          orElse: () => WordCategory(id: id, label: id),
        )
        .label;
  }

  List<WordEntry> wordsForCategory(String id) {
    return words.where((w) => w.tags.contains(id)).toList();
  }

  WordEntry wordOfTheDay([DateTime? date]) {
    final now = date ?? DateTime.now();
    final start = DateTime(now.year, 1, 0);
    final dayOfYear = now.difference(start).inDays;
    return words[dayOfYear % words.length];
  }

  List<WordEntry> search({
    String query = '',
    List<String> tags = const [],
    Set<String>? ids,
  }) {
    Iterable<WordEntry> result = words;
    if (ids != null) {
      result = result.where((w) => ids.contains(w.id));
    }
    if (tags.isNotEmpty) {
      result = result.where((w) => w.tags.any(tags.contains));
    }
    final trimmed = query.trim().toLowerCase();
    if (trimmed.isEmpty) return result.toList();

    final terms = trimmed
        .split(RegExp(r'\s+'))
        .where((t) => t.isNotEmpty && !_stopwords.contains(t))
        .toList();

    final scored = <({WordEntry word, int score})>[];
    for (final word in result) {
      final haystack = word.searchable;
      var score = 0;
      if (word.word.toLowerCase().contains(trimmed)) score += 12;
      if (haystack.contains(trimmed)) score += 6;
      for (final term in terms) {
        if (word.word.toLowerCase().contains(term)) {
          score += 5;
        } else if (haystack.contains(term)) {
          score += 2;
        }
      }
      if (score > 0) scored.add((word: word, score: score));
    }
    scored.sort((a, b) => b.score.compareTo(a.score));
    return scored.map((e) => e.word).toList();
  }
}
