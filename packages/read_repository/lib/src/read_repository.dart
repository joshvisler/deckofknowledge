import 'package:read_api/read_api.dart';

class ReadRepository {
  const ReadRepository({
    required ReadApi cardsApi,
  }) : _readApi = cardsApi;

  final ReadApi _readApi;

  Future<void> addDialog(ReadDialog dialog) => _readApi.addDialog(dialog);
  Future<void> addArticle(ReadArticle article) => _readApi.addArticle(article);

  Future<void> deleteDialog(String id) => _readApi.deleteDialog(id);
  Future<void> deleteArticle(String id) => _readApi.deleteArticle(id);

  Stream<List<ReadDialog>> getDialogs() => _readApi.getDialogs();
  Stream<List<ReadArticle>> getArticles() => _readApi.getArticles();
}
