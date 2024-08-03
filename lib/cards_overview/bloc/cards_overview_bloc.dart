import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cards_overview_event.dart';
part 'cards_overview_state.dart';

class CardsOverviewBloc extends Bloc<CardsOverviewEvent, CardsOverviewState> {
  CardsOverviewBloc() : super(CardsOverviewInitial()) {
    on<CardsOverviewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
