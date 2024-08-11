import 'package:decks_repository/src/cards/models/splashcard_model.dart';

abstract class CardsApi {
  const CardsApi();

  Stream<List<SplashCardModel>> get();

  Future<void> add(SplashCardModel model);

  Future<void> delete(String id);

  Future<void> update(SplashCardModel model);
}
