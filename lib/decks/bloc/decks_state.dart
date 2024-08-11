part of 'decks_bloc.dart';

enum DecksViewStatus { initial, loading, success, failure }

enum TabType { cards, texts }

final class DecksState extends Equatable {
  const DecksState(
      {this.decks = const [],
      this.status = DecksViewStatus.initial,
      this.title = '',
      this.currentTab = TabType.cards});

  final List<DeckModel> decks;
  final DecksViewStatus status;
  final String title;
  final TabType currentTab;

  DecksState copyWith({
    DecksViewStatus Function()? status,
    List<DeckModel> Function()? decks,
    String Function()? title,
    TabType Function()? currentTab,
  }) {
    return DecksState(
        status: status != null ? status() : this.status,
        decks: decks != null ? decks() : this.decks,
        title: title != null ? title() : this.title,
        currentTab: currentTab != null ? currentTab() : this.currentTab);
  }

  @override
  List<Object?> get props => [status, decks, title, currentTab];
}
