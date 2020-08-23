import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cheers/data/model/beer_model.dart';
import 'package:cheers/data/repositories/beer_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'beer_event.dart';
part 'beer_state.dart';

class BeerBloc extends Bloc<BeerEvent, BeerState> {
  BeerRepository repository;

  BeerBloc({@required this.repository}) : super(null);

  BeerState get initialState => BeerInitialState();
  @override
  Stream<BeerState> mapEventToState(
    BeerEvent event,
  ) async* {
    if (event is FetchBeerEvent) {
      yield BeerLoadingState();
      try {
        List data = await repository.getBeers(event.page);
        List<BeerModel> beers = data.map((e) => BeerModel.fromJson(e)).toList();
        yield BeerLoadedState(beers: beers);
      } catch (e) {
        yield BeerLoadingErrorState(
          message: e.toString(),
        );
      }
    }
  }
}
