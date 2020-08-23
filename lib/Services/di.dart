import 'package:cheers/bloc/beer_bloc/beer_bloc.dart';
import 'package:cheers/data/repositories/beer_repository.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> initDI() async {
  _blocRegister();
}

void _blocRegister() {
  sl.registerFactory(() => BeerBloc(repository: sl()));
  sl.registerLazySingleton<BeerRepository>(() => BeerRepositoryImpl());
}
