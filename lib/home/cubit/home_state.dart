part of 'home_cubit.dart';

enum HomeTab { cards, read, play }

final class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.cards,
  });

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}
