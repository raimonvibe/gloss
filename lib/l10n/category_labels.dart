import 'app_localizations.dart';

String localizedCategoryLabel(AppLocalizations l10n, String id) {
  return switch (id) {
    'speech' => l10n.categorySpeech,
    'character' => l10n.categoryCharacter,
    'criticism' => l10n.categoryCriticism,
    'virtue' => l10n.categoryVirtue,
    'vice' => l10n.categoryVice,
    'knowledge' => l10n.categoryKnowledge,
    'religion' => l10n.categoryReligion,
    'beginnings' => l10n.categoryBeginnings,
    'conflict' => l10n.categoryConflict,
    'appearance' => l10n.categoryAppearance,
    'people' => l10n.categoryPeople,
    'objects' => l10n.categoryObjects,
    'emotion' => l10n.categoryEmotion,
    'archaic' => l10n.categoryArchaic,
    _ => id,
  };
}

String localizedContinent(AppLocalizations l10n, String continent) {
  return switch (continent) {
    'Africa' => l10n.continentAfrica,
    'Asia' => l10n.continentAsia,
    'Europe' => l10n.continentEurope,
    'Americas' => l10n.continentAmericas,
    'Oceania' => l10n.continentOceania,
    _ => continent,
  };
}
