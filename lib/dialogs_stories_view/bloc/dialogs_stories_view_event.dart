part of 'dialogs_stories_view_bloc.dart';

sealed class DialogsStoriesViewEvent extends Equatable {
  const DialogsStoriesViewEvent();

  @override
  List<Object> get props => [];
}

final class DialogsStoriesViewInitial extends DialogsStoriesViewEvent {
  const DialogsStoriesViewInitial();
}

final class DialogsStoriesGenerate extends DialogsStoriesViewEvent {
  const DialogsStoriesGenerate(this.type, this.theme);

  final TextType type;
  final String theme;
}

final class DialogsStoriesTypeChanged extends DialogsStoriesViewEvent {
  const DialogsStoriesTypeChanged(this.type);

  final TextType type;
}

final class DialogsStoriesThemeChanged extends DialogsStoriesViewEvent {
  const DialogsStoriesThemeChanged(this.theme);

  final String theme;
}
