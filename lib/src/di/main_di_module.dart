import 'package:casino_test/src/data/data_source/characters_api.dart';
import 'package:casino_test/src/domain/repositories/characters_repository.dart';
import 'package:casino_test/src/data/repository/characters_repository_impl.dart';
import 'package:casino_test/src/domain/use_cases/get_chatacters_use_case.dart';
import 'package:casino_test/src/presentation/cubit/characters_screen_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

class MainDIModule {
  void configure() {
    final httpClient =
        Dio(BaseOptions(baseUrl: 'https://rickandmortyapi.com/api'));

    di.registerLazySingleton<CharactersApi>(() => CharactersApi(httpClient));
    di.registerLazySingleton<CharactersRepository>(
        () => CharactersRepositoryImpl(api: di.get<CharactersApi>()));

    di.registerLazySingleton<GetCharactersUseCase>(() =>
        GetCharactersUseCaseImpl(repository: di.get<CharactersRepository>()));

    di.registerFactory<CharactersScreenCubit>(() => CharactersScreenCubit(
        getCharactersUseCase: di.get<GetCharactersUseCase>()));
  }
}
