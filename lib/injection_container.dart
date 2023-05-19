import 'package:clean_archi_flutter_app/core/network/network_info.dart';
import 'package:clean_archi_flutter_app/core/util/input_converter.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/domain/repositories/number_trivia_repository_interface.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_archi_flutter_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';

// ! GetIt.instance.registerFactory(func);
final sl = GetIt.instance;

Future<void> init() async {
  // ! Features - Number Trivia
  // Bloc
  sl.registerFactory(() => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repositories
  sl.registerLazySingleton<INumberTriviaRepository>(() =>
      NumberTriviaRepository(
          localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<INumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSource(client: sl()));
  sl.registerLazySingleton<INumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSource(sharedPreferences: sl()));

  // ! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(sl()));

  // ! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
