part of 'edit_word_card_bloc.dart';

sealed class EditWordCardEvent extends Equatable {
  const EditWordCardEvent();

  @override
  List<Object> get props => [];
}

final class EditWordCardSubscriptionRequested extends EditWordCardEvent {
  const EditWordCardSubscriptionRequested(this.isCreating, this.card);

  final bool isCreating;
  final WordCard? card;
}

final class EditWordCardGenerateCard extends EditWordCardEvent {
  const EditWordCardGenerateCard();
}

final class EditWordCardSave extends EditWordCardEvent {
  const EditWordCardSave();
}

final class EditWordEnterWord extends EditWordCardEvent {
  const EditWordEnterWord(this.word);

  final String word;
}
