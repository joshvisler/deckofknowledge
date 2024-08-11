import 'package:decks_repository/src/stories/models/story_model.dart';

abstract class StoriesApi {
  const StoriesApi();

  Stream<List<StoryModel>> get();

  Future<void> add(StoryModel model);

  Future<void> delete(String id);

  Future<void> update(StoryModel model);
}
