import 'package:decks_repository/src/stories/models/story_model.dart';
import 'package:decks_repository/src/stories/stories_api.dart';

class StoriesRepository {
  const StoriesRepository({
    required StoriesApi storiesApi,
  }) : _storiesApi = storiesApi;

  final StoriesApi _storiesApi;

  Future<void> add(StoryModel model) => _storiesApi.add(model);

  Future<void> delete(String id) => _storiesApi.delete(id);

  Stream<List<StoryModel>> get() => _storiesApi.get();

  Future<void> update(StoryModel model) => _storiesApi.update(model);
}
