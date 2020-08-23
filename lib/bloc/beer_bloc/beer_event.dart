part of 'beer_bloc.dart';

@immutable
abstract class BeerEvent extends Equatable {}

class FetchBeerEvent extends BeerEvent {
  final int page;
  FetchBeerEvent({@required this.page});
  @override
  List<Object> get props => [page];
}
