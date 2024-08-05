part of 'edit_word_card_bloc.dart';

sealed class EditWordCardEvent extends Equatable {
  const EditWordCardEvent();

  @override
  List<Object> get props => [];
}

final class EditWordCardSubscriptionRequested extends EditWordCardEvent {
  const EditWordCardSubscriptionRequested();
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
