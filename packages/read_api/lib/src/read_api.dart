import 'package:read_api/src/models/read_article.dart';
import 'package:read_api/src/models/read_dialog.dart';

abstract class ReadApi {
  const ReadApi();

  Stream<List<ReadDialog>> getDialogs();
  Stream<List<ReadArticle>> getArticles();

  Future<void> addDialog(ReadDialog dialog);
  Future<void> addArticle(ReadArticle article);

  Future<void> deleteDialog(String id);
  Future<void> deleteArticle(String id);
}
