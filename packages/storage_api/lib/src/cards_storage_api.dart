import 'dart:convert';

import 'package:decks_repository/decks_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardsStorageApi extends CardsApi {
  CardsStorageApi({required SharedPreferences preferences})
      : _preferences = preferences {
    _init();
  }

  final SharedPreferences _preferences;

  late final _cardsStreamController =
      BehaviorSubject<List<SplashCardModel>>.seeded(
    const [],
  );

  @visibleForTesting
  static const kCardsCollectionKey = '__cardss_collection_key__';

  String? _getValue(String key) => _preferences.getString(key);
  Future<void> _setValue(String key, String value) =>
      _preferences.setString(key, value);

  void _init() {
    final cardsJson = _getValue(kCardsCollectionKey);
    if (cardsJson != null) {
      final cards = List<Map<dynamic, dynamic>>.from(
        json.decode(cardsJson) as List,
      )
          .map((jsonMap) =>
              SplashCardModel.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _cardsStreamController.add(cards);
    } else {
      _cardsStreamController.add(const []);
    }
  }

  @override
  Future<void> add(SplashCardModel model) {
    final cards = [..._cardsStreamController.value, model];
    final cardIndex = cards.indexWhere((c) => c.id == model.id);
    if (cardIndex != -1) {
      cards[cardIndex] = model;
    } else {
      cards.add(model);
    }

    _cardsStreamController.add(cards);
    return _setValue(kCardsCollectionKey, json.encode(cards));
  }

  @override
  Future<void> delete(String id) {
    final cards = [..._cardsStreamController.value];
    final cardIndex = cards.indexWhere((c) => c.id == id);

    if (cardIndex != -1) {
      cards.removeAt(cardIndex);
      _cardsStreamController.add(cards);
      return _setValue(kCardsCollectionKey, json.encode(cards));
    } else {
      throw CardNotFoundException();
    }
  }

  @override
  Stream<List<SplashCardModel>> get() {
    return _cardsStreamController.asBroadcastStream();
  }

  @override
  Future<void> update(SplashCardModel model) {
    final cards = [..._cardsStreamController.value, model];
    final cardIndex = cards.indexWhere((c) => c.id == model.id);

    if (cardIndex != -1) {
      cards[cardIndex] = model;
    }

    _cardsStreamController.add(cards);
    return _setValue(kCardsCollectionKey, json.encode(cards));
  }
}
