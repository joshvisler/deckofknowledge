part of 'edit_word_card_bloc.dart';

enum EditCardStatus { initial, editing, generating, saving, success, failure }

final class EditWordCardState extends Equatable {
  const EditWordCardState(
      {this.status = EditCardStatus.initial,
      this.card,
      this.isCreating = false,
      this.wordText = ''});

  final WordCard? card;
  final EditCardStatus status;
  final bool isCreating;
  final String wordText;

  EditWordCardState copyWith({
    EditCardStatus Function()? status,
    WordCard? Function()? card,
    bool Function()? isCreating,
    String Function()? wordText,
  }) {
    return EditWordCardState(
        status: status != null ? status() : this.status,
        card: card != null ? card() : this.card,
        isCreating: isCreating != null ? isCreating() : this.isCreating,
        wordText: wordText != null ? wordText() : this.wordText);
  }

  @override
  List<Object?> get props => [status, card, isCreating, wordText];
}
