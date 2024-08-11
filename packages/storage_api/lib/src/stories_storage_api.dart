import 'dart:convert';

import 'package:decks_repository/decks_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoriesStorageApi extends StoriesApi {
  StoriesStorageApi({required SharedPreferences preferences})
      : _preferences = preferences {
    _init();
  }

  final SharedPreferences _preferences;

  late final _storiesStreamController =
      BehaviorSubject<List<StoryModel>>.seeded(
    const [],
  );

  @visibleForTesting
  static const kStoriesCollectionKey = '__stories_collection_key__';

  String? _getValue(String key) => _preferences.getString(key);
  Future<void> _setValue(String key, String value) =>
      _preferences.setString(key, value);

  void _init() {
    final storiesJson = _getValue(kStoriesCollectionKey);
    if (storiesJson != null) {
      final stories = List<Map<dynamic, dynamic>>.from(
        json.decode(storiesJson) as List,
      )
          .map((jsonMap) =>
              StoryModel.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _storiesStreamController.add(stories);
    } else {
      _storiesStreamController.add(const []);
    }
  }

  @override
  Future<void> add(StoryModel model) {
    final stories = [..._storiesStreamController.value, model];
    final cardIndex = stories.indexWhere((c) => c.id == model.id);
    if (cardIndex != -1) {
      stories[cardIndex] = model;
    } else {
      stories.add(model);
    }

    _storiesStreamController.add(stories);
    return _setValue(kStoriesCollectionKey, json.encode(stories));
  }

  @override
  Future<void> delete(String id) {
    final stories = [..._storiesStreamController.value];
    final cardIndex = stories.indexWhere((c) => c.id == id);

    if (cardIndex != -1) {
      stories.removeAt(cardIndex);
      _storiesStreamController.add(stories);
      return _setValue(kStoriesCollectionKey, json.encode(stories));
    } else {
      throw CardNotFoundException();
    }
  }

  @override
  Stream<List<StoryModel>> get() {
    return _storiesStreamController.asBroadcastStream();
  }

  @override
  Future<void> update(StoryModel model) {
    final stories = [..._storiesStreamController.value, model];
    final cardIndex = stories.indexWhere((c) => c.id == model.id);

    if (cardIndex != -1) {
      stories[cardIndex] = model;
    }

    _storiesStreamController.add(stories);
    return _setValue(kStoriesCollectionKey, json.encode(stories));
  }
}
