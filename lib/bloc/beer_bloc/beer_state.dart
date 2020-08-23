part of 'beer_bloc.dart';

@immutable
abstract class BeerState extends Equatable {}

class BeerInitialState extends BeerState {
  @override
  List<Object> get props => [];
}

class BeerLoadingState extends BeerState {
  @override
  List<Object> get props => [];
}

class BeerLoadedState extends BeerState {
  final List<BeerModel> beers;
  BeerLoadedState({@required this.beers});
  @override
  List<Object> get props => [beers];
}

class BeerLoadingErrorState extends BeerState {
  final String message;

  BeerLoadingErrorState({@required this.message});
  @override
  List<Object> get props => [message];
}
