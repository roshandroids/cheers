part of 'beer_bloc.dart';

@immutable
abstract class BeerState extends Equatable {}

class BeerInitialState extends BeerState {
  @override
  List<Object> get props => [];
}

class BeerLoadingState extends Equatable {
  @override
  List<Object> get props => [];
}

class BeerLoadedState extends Equatable {
  final List<BeerModel> beers;
  BeerLoadedState({@required this.beers});
  @override
  List<Object> get props => [beers];
}

class BeerLoadingErrorState extends Equatable {
  final String message;

  BeerLoadingErrorState({@required this.message});
  @override
  List<Object> get props => [message];
}
