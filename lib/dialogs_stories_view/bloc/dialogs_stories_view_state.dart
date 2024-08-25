part of 'dialogs_stories_view_bloc.dart';

enum DialogsStoriesViewStatus { initial, loading, success, failure }

final class DialogsStoriesViewState extends Equatable {
  const DialogsStoriesViewState(
      {this.status = DialogsStoriesViewStatus.initial,
      this.texts = const [],
      this.selectedType = TextType.story,
      this.theme = '',
      this.deckId = '',});

  final List<DialogStoryModel> texts;
  final DialogsStoriesViewStatus status;
  final TextType selectedType;
  final String theme;
  final String deckId;

  DialogsStoriesViewState copyWith({
    DialogsStoriesViewStatus Function()? status,
    List<DialogStoryModel> Function()? texts,
    TextType Function()? selectedType,
    String Function()? theme,
    String Function()? deckId,
  }) {
    return DialogsStoriesViewState(
      status: status != null ? status() : this.status,
      texts: texts != null ? texts() : this.texts,
      selectedType: selectedType != null ? selectedType() : this.selectedType,
      theme: theme != null ? theme() : this.theme,
      deckId: deckId != null ? deckId() : this.deckId,
    );
  }

  @override
  List<Object?> get props => [status, deckId, texts, selectedType, theme];
}
