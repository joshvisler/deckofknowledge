import 'package:cards_api/src/models/card.dart';

abstract class CardsApi {
  const CardsApi();

  Stream<List<Card>> getCards();

  Future<void> addCard(Card card);

  Future<void> deleteCard(String id);

  Future<void> updateCard(Card card);
}
