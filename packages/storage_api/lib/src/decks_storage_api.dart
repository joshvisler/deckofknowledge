import 'dart:convert';

import 'package:decks_repository/decks_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DecksStorageApi extends DecksApi {
  DecksStorageApi({required SharedPreferences preferences})
      : _preferences = preferences {
    _init();
  }

  final SharedPreferences _preferences;

  late final _decksStreamController = BehaviorSubject<List<DeckModel>>.seeded(
    const [],
  );

  @visibleForTesting
  static const kDecksCollectionKey = '__decks_collection_key__';

  String? _getValue(String key) => _preferences.getString(key);
  Future<void> _setValue(String key, String value) =>
      _preferences.setString(key, value);

  void _init() {
    final decksJson = _getValue(kDecksCollectionKey);
    if (decksJson != null) {
      final decks = List<Map<dynamic, dynamic>>.from(
        json.decode(decksJson) as List,
      )
          .map((jsonMap) =>
              DeckModel.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _decksStreamController.add(decks);
    } else {
      _decksStreamController.add(const []);
    }
  }

  @override
  Future<void> add(DeckModel model) {
    final decks = [..._decksStreamController.value, model];
    final cardIndex = decks.indexWhere((c) => c.id == model.id);
    if (cardIndex != -1) {
      decks[cardIndex] = model;
    } else {
      decks.add(model);
    }

    _decksStreamController.add(decks);
    return _setValue(kDecksCollectionKey, json.encode(decks));
  }

  @override
  Future<void> delete(String id) {
    final decks = [..._decksStreamController.value];
    final cardIndex = decks.indexWhere((c) => c.id == id);

    if (cardIndex != -1) {
      decks.removeAt(cardIndex);
      _decksStreamController.add(decks);
      return _setValue(kDecksCollectionKey, json.encode(decks));
    } else {
      throw CardNotFoundException();
    }
  }

  @override
  Stream<List<DeckModel>> get() {
    return _decksStreamController.asBroadcastStream();
  }

  @override
  Future<void> update(DeckModel model) {
    final decks = [..._decksStreamController.value, model];
    final cardIndex = decks.indexWhere((c) => c.id == model.id);

    if (cardIndex != -1) {
      decks[cardIndex] = model;
    }

    _decksStreamController.add(decks);
    return _setValue(kDecksCollectionKey, json.encode(decks));
  }
}
