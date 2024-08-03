import 'dart:convert';

import 'package:cards_api/cards_api.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardsStorageApi extends CardsApi {
  CardsStorageApi({required SharedPreferences preferences})
      : _preferences = preferences {
    _init();
  }

  final SharedPreferences _preferences;

  late final _cardsStreamController = BehaviorSubject<List<Card>>.seeded(
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
          .map((jsonMap) => Card.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _cardsStreamController.add(cards);
    } else {
      _cardsStreamController.add(const []);
    }
  }

  @override
  Future<void> addCard(Card card) {
    final cards = [..._cardsStreamController.value, card];
    final cardIndex = cards.indexWhere((c) => c.id == card.id);
    if (cardIndex != -1) {
      cards[cardIndex] = card;
    } else {
      cards.add(card);
    }

    _cardsStreamController.add(cards);
    return _setValue(kCardsCollectionKey, json.encode(cards));
  }

  @override
  Future<void> deleteCard(String id) {
    final cards = [..._cardsStreamController.value];
    final cardIndex = cards.indexWhere((c) => c.id == id);

    if (cardIndex != -1) {
      throw CardNotFoundException();
    } else {
      cards.removeAt(cardIndex);
      _cardsStreamController.add(cards);
      return _setValue(kCardsCollectionKey, json.encode(cards));
    }
  }

  @override
  Stream<List<Card>> getCards() {
    return _cardsStreamController.asBroadcastStream();
  }

  @override
  Future<void> updateCard(Card card) {
    final cards = [..._cardsStreamController.value, card];
    final cardIndex = cards.indexWhere((c) => c.id == card.id);

    if (cardIndex != -1) {
      cards[cardIndex] = card;
    }

    _cardsStreamController.add(cards);
    return _setValue(kCardsCollectionKey, json.encode(cards));
  }
}
