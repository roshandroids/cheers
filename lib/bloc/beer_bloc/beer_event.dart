part of 'beer_bloc.dart';

@immutable
abstract class BeerEvent extends Equatable {}

class FetchBeerEvent extends BeerEvent {
  @override
  List<Object> get props => [];
}
