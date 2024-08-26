import 'package:decks_repository/decks_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_api/gemini_api.dart';
import 'package:myapp/dialogs_stories_view/models/dialog_story_model.dart';

import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'dialogs_stories_view_event.dart';
part 'dialogs_stories_view_state.dart';

class DialogsStoriesViewBloc
    extends Bloc<DialogsStoriesViewEvent, DialogsStoriesViewState> {
  DialogsStoriesViewBloc(
      {required DialogsRepository dialogsRepository,
      required StoriesRepository storiesRepository,
      required GeminiRepository geminiRepository,
      required DecksRepository decksRepository
      })
      : _dialogsRepository = dialogsRepository,
        _storiesRepository = storiesRepository,
        _geminiRepository = geminiRepository,
        _decksRepository = decksRepository,
        super(DialogsStoriesViewState(deckId: '')) {
    on<DialogsStoriesViewInitial>(_onInitial);
    on<DialogsStoriesGenerate>(_onGenerate);
    on<DialogsStoriesThemeChanged>(_onThemeChanged);
    on<DialogsStoriesTypeChanged>(_onTypeChanged);
  }

  final DialogsRepository _dialogsRepository;
  final StoriesRepository _storiesRepository;
  final GeminiRepository _geminiRepository;
  final DecksRepository _decksRepository;

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
        texts: () => dialogsStories,
        deckId: () => event.deckId));
  }

  Future<void> _onGenerate(
    DialogsStoriesGenerate event,
    Emitter<DialogsStoriesViewState> emit,
  ) async {
    emit(state.copyWith(status: () => DialogsStoriesViewStatus.loading));

    var texts = state.texts.toList();
    var deck = (await _decksRepository.get().first).firstWhere((d) => d.id ==  state.deckId);

    if (event.type == TextType.dialog) {
      var model = await _geminiRepository.generateDialog(event.theme, deck.languageFrom, deck.languageTo);
      var text = DialogStoryModel(
          deckId: state.deckId,
          id: model.id,
          text: model.text,
          theme: model.theme,
          translate: model.translate,
          type: TextType.dialog);
      var dialog = DialogModel(
          text: text.text,
          translate: text.translate,
          theme: text.theme,
          deckId: text.deckId);
      await _dialogsRepository.add(dialog);
      texts.add(text);
    } else {
      var model = await _geminiRepository.generateStory(event.theme, deck.languageFrom, deck.languageTo);
      var text = DialogStoryModel(
          deckId: state.deckId,
          id: model.id,
          text: model.text,
          theme: model.theme,
          translate: model.translate,
          type: TextType.story);
      var story = StoryModel(
          text: text.text,
          translate: text.translate,
          theme: text.theme,
          deckId: text.deckId);

      await _storiesRepository.add(story);
      texts.add(text);
    }

    emit(state.copyWith(
        status: () => DialogsStoriesViewStatus.success, texts: () => texts));
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
