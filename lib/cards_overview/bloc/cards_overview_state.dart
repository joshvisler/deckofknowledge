part of 'cards_overview_bloc.dart';

sealed class CardsOverviewState extends Equatable {
  const CardsOverviewState();
  
  @override
  List<Object> get props => [];
}

final class CardsOverviewInitial extends CardsOverviewState {}
