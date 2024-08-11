import 'package:decks_repository/src/decks/models/deck_model.dart';

abstract class DecksApi {
  const DecksApi();

  Stream<List<DeckModel>> get();

  Future<void> add(DeckModel model);

  Future<void> delete(String id);

  Future<void> update(DeckModel model);
}
