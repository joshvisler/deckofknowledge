import 'package:decks_repository/decks_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_api/gemini_api.dart';
import 'package:myapp/dialogs_stories_view/models/dialog_story_model.dart';

part 'dialogs_stories_view_event.dart';
part 'dialogs_stories_view_state.dart';

class DialogsStoriesViewBloc
    extends Bloc<DialogsStoriesViewEvent, DialogsStoriesViewState> {
  DialogsStoriesViewBloc(
      {required DialogsRepository dialogsRepository,
      required StoriesRepository storiesRepository,
      required GeminiRepository geminiRepository})
      : _dialogsRepository = dialogsRepository,
        _storiesRepository = storiesRepository,
        _geminiRepository = geminiRepository,
        super(const DialogsStoriesViewState()) {
    on<DialogsStoriesViewInitial>(_onInitial);
    on<DialogsStoriesGenerate>(_onGenerate);
    on<DialogsStoriesThemeChanged>(_onThemeChanged);
    on<DialogsStoriesTypeChanged>(_onTypeChanged);
  }

  final DialogsRepository _dialogsRepository;
  final StoriesRepository _storiesRepository;
  final GeminiRepository _geminiRepository;

  Future<void> _onInitial(
    DialogsStoriesViewInitial event,
    Emitter<DialogsStoriesViewState> emit,
  ) async {
    emit(state.copyWith(status: () => DialogsStoriesViewStatus.loading));

    var dialogs = await _dialogsRepository.get().first;
    var stories = await _storiesRepository.get().first;

    var dialogsStories = dialogs
        .map((dialog) => DialogStoryModel.copyWithDialog(dialog: dialog))
        .toList();
    dialogsStories.addAll(
        stories.map((story) => DialogStoryModel.copyWithStory(story: story)));

    emit(state.copyWith(
        status: () => DialogsStoriesViewStatus.initial,
        texts: () => dialogsStories));
  }

  Future<void> _onGenerate(
    DialogsStoriesGenerate event,
    Emitter<DialogsStoriesViewState> emit,
  ) async {
    emit(state.copyWith(status: () => DialogsStoriesViewStatus.loading));

    if (event.type == TextType.dialog) {
      var model = await _geminiRepository.generateDialog(event.theme);
      await _dialogsRepository.add(model);
      var text = DialogStoryModel.copyWithDialog(dialog: model);
      state.texts.add(text);
    } else {
      var model = await _geminiRepository.generateStory(event.theme);
      await _storiesRepository.add(model);
      var text = DialogStoryModel.copyWithStory(story: model);
      state.texts.add(text);
    }

    emit(state.copyWith(
        status: () => DialogsStoriesViewStatus.initial,
        texts: () => state.texts));
  }

  Future<void> _onThemeChanged(
    DialogsStoriesThemeChanged event,
    Emitter<DialogsStoriesViewState> emit,
  ) async {
    emit(state.copyWith(
        status: () => DialogsStoriesViewStatus.initial,
        theme: () => event.theme));
  }

  Future<void> _onTypeChanged(
    DialogsStoriesTypeChanged event,
    Emitter<DialogsStoriesViewState> emit,
  ) async {
    emit(state.copyWith(
        status: () => DialogsStoriesViewStatus.initial,
        selectedType: () => event.type));
  }
}
