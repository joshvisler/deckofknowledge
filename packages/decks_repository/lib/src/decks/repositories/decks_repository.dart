import 'package:decks_repository/src/decks/decks_api.dart';
import 'package:decks_repository/src/decks/models/deck_model.dart';

class DecksRepository {
  const DecksRepository({
    required DecksApi decksApi,
  }) : _decksApi = decksApi;

  final DecksApi _decksApi;

  Future<void> add(DeckModel model) => _decksApi.add(model);

  Future<void> delete(String id) => _decksApi.delete(id);

  Stream<List<DeckModel>> get() => _decksApi.get();

  Future<void> update(DeckModel model) => _decksApi.update(model);
}
