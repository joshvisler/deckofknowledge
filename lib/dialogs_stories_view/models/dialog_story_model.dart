import 'package:decks_repository/decks_repository.dart';

enum TextType { dialog, story }

class DialogStoryModel {
  DialogStoryModel(
      {required this.id,
      required this.deckId,
      required this.text,
      required this.translate,
      required this.theme,
      required this.type});

  final String id;
  final String deckId;
  final List<String> text;
  final List<String> translate;
  final String theme;
  final TextType type;

  static DialogStoryModel copyWithDialog({required DialogModel dialog}) {
    return DialogStoryModel(
      id: dialog.id,
      deckId: dialog.deckId,
      text: dialog.text,
      theme: dialog.theme,
      translate: dialog.translate,
      type: TextType.dialog,
    );
  }

  static DialogStoryModel copyWithStory({required StoryModel story}) {
    return DialogStoryModel(
      id: story.id,
      deckId: story.deckId,
      text: story.text,
      theme: story.theme,
      translate: story.translate,
      type: TextType.story,
    );
  }
}
