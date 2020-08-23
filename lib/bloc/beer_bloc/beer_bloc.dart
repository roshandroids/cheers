import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cheers/data/model/beer_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'beer_event.dart';
part 'beer_state.dart';

class BeerBloc extends Bloc<BeerEvent, BeerState> {
  BeerBloc(BeerState initialState) : super(initialState);

  BeerState get initialState => BeerInitialState();
  @override
  Stream<BeerState> mapEventToState(
    BeerEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
