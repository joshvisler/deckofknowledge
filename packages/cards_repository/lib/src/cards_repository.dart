import 'package:cards_api/cards_api.dart';

class CardsRepository {
  const CardsRepository({
    required CardsApi cardsApi,
  }) : _cardsApi = cardsApi;

  final CardsApi _cardsApi;

  Future<void> addCard(WordCard card) => _cardsApi.addCard(card);

  Future<void> deleteCard(String id) => _cardsApi.deleteCard(id);

  Stream<List<WordCard>> getCards() => _cardsApi.getCards();

  Future<void> updateCard(WordCard card) => _cardsApi.updateCard(card);
}
