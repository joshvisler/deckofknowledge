part of 'dialogs_stories_view_bloc.dart';

enum DialogsStoriesViewStatus { initial, loading, success, failure }

final class DialogsStoriesViewState extends Equatable {
  const DialogsStoriesViewState(
      {this.status = DialogsStoriesViewStatus.initial,
      this.texts = const [],
      this.selectedType = TextType.story,
      this.theme = ''});

  final List<DialogStoryModel> texts;
  final DialogsStoriesViewStatus status;
  final TextType selectedType;
  final String theme;

  DialogsStoriesViewState copyWith({
    DialogsStoriesViewStatus Function()? status,
    List<DialogStoryModel> Function()? texts,
    TextType Function()? selectedType,
    String Function()? theme,
  }) {
    return DialogsStoriesViewState(
      status: status != null ? status() : this.status,
      texts: texts != null ? texts() : this.texts,
      selectedType: selectedType != null ? selectedType() : this.selectedType,
      theme: theme != null ? theme() : this.theme,
    );
  }

  @override
  List<Object?> get props => [status, texts, selectedType, theme];
}
