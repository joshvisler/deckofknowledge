import 'package:decks_repository/decks_repository.dart';

class CardsRepository {
  const CardsRepository({
    required CardsApi cardsApi,
  }) : _cardsApi = cardsApi;

  final CardsApi _cardsApi;

  Future<void> add(SplashCardModel model) => _cardsApi.add(model);

  Future<void> delete(String id) => _cardsApi.delete(id);

  Stream<List<SplashCardModel>> get() => _cardsApi.get();

  Future<void> update(SplashCardModel model) => _cardsApi.update(model);
}
