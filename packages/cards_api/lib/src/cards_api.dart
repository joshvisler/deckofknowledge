import 'package:cards_api/src/models/word_card.dart';

abstract class CardsApi {
  const CardsApi();

  Stream<List<WordCard>> getCards();

  Future<void> addCard(WordCard card);

  Future<void> deleteCard(String id);

  Future<void> updateCard(WordCard card);
}
