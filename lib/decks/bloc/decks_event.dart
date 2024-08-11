part of 'decks_bloc.dart';

sealed class DecksEvent extends Equatable {
  const DecksEvent();

  @override
  List<Object> get props => [];
}

final class DecksInitial extends DecksEvent {
  const DecksInitial();
}

final class CreateDeck extends DecksEvent {
  const CreateDeck();
}

final class CreateDeckTitleChanged extends DecksEvent {
  const CreateDeckTitleChanged(this.name);

  final String name;
}

final class TabChanged extends DecksEvent {
  const TabChanged(this.index);

  final int index;
}

