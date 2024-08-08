import 'dart:convert';

import 'package:cards_api/cards_api.dart';
import 'package:meta/meta.dart';
import 'package:read_api/read_api.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadStorageApi extends ReadApi {
  ReadStorageApi({required SharedPreferences preferences})
      : _preferences = preferences {
    _init();
  }

  final SharedPreferences _preferences;

  late final _dialogsStreamController =
      BehaviorSubject<List<ReadDialog>>.seeded(
    const [],
  );

  late final _articlesStreamController =
      BehaviorSubject<List<ReadArticle>>.seeded(
    const [],
  );

  @visibleForTesting
  static const kDialogsCollectionKey = '__dialogs_collection_key__';
  static const kArticlesCollectionKey = '__articles_collection_key__';

  String? _getValue(String key) => _preferences.getString(key);
  Future<void> _setValue(String key, String value) =>
      _preferences.setString(key, value);

  void _init() {
    final dialogsJson = _getValue(kDialogsCollectionKey);
    final articlesJson = _getValue(kArticlesCollectionKey);

    if (dialogsJson != null) {
      final dialogs = List<Map<dynamic, dynamic>>.from(
        json.decode(dialogsJson) as List,
      )
          .map((jsonMap) =>
              ReadDialog.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _dialogsStreamController.add(dialogs);
    } else {
      _dialogsStreamController.add(const []);
    }

    if (articlesJson != null) {
      final articles = List<Map<dynamic, dynamic>>.from(
        json.decode(articlesJson) as List,
      )
          .map((jsonMap) =>
              ReadArticle.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _articlesStreamController.add(articles);
    } else {
      _articlesStreamController.add(const []);
    }
  }

  @override
  Future<void> addDialog(ReadDialog dialog) {
    final dialogs = [..._dialogsStreamController.value, dialog];
    final dialogIndex = dialogs.indexWhere((c) => c.id == dialog.id);
    if (dialogIndex != -1) {
      dialogs[dialogIndex] = dialog;
    } else {
      dialogs.add(dialog);
    }

    _dialogsStreamController.add(dialogs);
    return _setValue(kDialogsCollectionKey, json.encode(dialogs));
  }

  @override
  Future<void> addArticle(ReadArticle article) {
    final articles = [..._articlesStreamController.value, article];
    final articleIndex = articles.indexWhere((c) => c.id == article.id);
    if (articleIndex != -1) {
      articles[articleIndex] = article;
    } else {
      articles.add(article);
    }

    _articlesStreamController.add(articles);
    return _setValue(kArticlesCollectionKey, json.encode(articles));
  }

  @override
  Future<void> deleteDialog(String id) {
    final dialogs = [..._dialogsStreamController.value];
    final cardIndex = dialogs.indexWhere((c) => c.id == id);

    if (cardIndex != -1) {
      dialogs.removeAt(cardIndex);
      _dialogsStreamController.add(dialogs);
      return _setValue(kDialogsCollectionKey, json.encode(dialogs));
    } else {
      throw CardNotFoundException();
    }
  }

  @override
  Future<void> deleteArticle(String id) {
    final articles = [..._articlesStreamController.value];
    final cardIndex = articles.indexWhere((c) => c.id == id);

    if (cardIndex != -1) {
      articles.removeAt(cardIndex);
      _articlesStreamController.add(articles);
      return _setValue(kArticlesCollectionKey, json.encode(articles));
    } else {
      throw CardNotFoundException();
    }
  }

  @override
  Stream<List<ReadDialog>> getDialogs() {
    return _dialogsStreamController.asBroadcastStream();
  }

  @override
  Stream<List<ReadArticle>> getArticles() {
    return _articlesStreamController.asBroadcastStream();
  }
}
