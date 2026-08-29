import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedSetStore extends ChangeNotifier {
  SavedSetStore(this._prefs, this._key) {
    _ids = _prefs.getStringList(_key)?.toSet() ?? <String>{};
  }

  final SharedPreferences _prefs;
  final String _key;
  late Set<String> _ids;

  Set<String> get ids => Set.unmodifiable(_ids);
  int get count => _ids.length;
  bool contains(String id) => _ids.contains(id);

  Future<void> toggle(String id) async {
    if (!_ids.add(id)) {
      _ids.remove(id);
    }
    notifyListeners();
    await _prefs.setStringList(_key, _ids.toList());
  }

  Future<void> add(String id) async {
    if (_ids.add(id)) {
      notifyListeners();
      await _prefs.setStringList(_key, _ids.toList());
    }
  }

  /// Empties the set. Destructive and not undoable, so every caller confirms
  /// with the reader first.
  Future<void> clear() async {
    if (_ids.isEmpty) return;
    _ids = <String>{};
    notifyListeners();
    await _prefs.setStringList(_key, const <String>[]);
  }
}

class ProgressController extends ChangeNotifier {
  ProgressController(SharedPreferences prefs)
      : favorites = SavedSetStore(prefs, 'beautiful-words:favorites'),
        explored = SavedSetStore(prefs, 'beautiful-words:explored') {
    favorites.addListener(notifyListeners);
    explored.addListener(notifyListeners);
  }

  final SavedSetStore favorites;
  final SavedSetStore explored;

  @override
  void dispose() {
    favorites.removeListener(notifyListeners);
    explored.removeListener(notifyListeners);
    super.dispose();
  }
}
