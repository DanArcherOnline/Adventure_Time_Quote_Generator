import 'package:adventure_time_quote_generator/features/quote_generator/data/repositories/quote_repository_impl.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/presentation/bloc/quote_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/quote_generator/data/datasources/quote_local_data_source.dart';
import 'features/quote_generator/data/datasources/quote_remote_data_source.dart';
import 'features/quote_generator/domain/repositories/quote_repository.dart';
import 'features/quote_generator/domain/usecases/get_random_quote.dart';

//Service Locator
final sl = GetIt.instance;

Future<void> init() async {
  initFeatures();
  initCore();
  await initExternal();
}

void initFeatures() {
  //* Bloc
  sl.registerFactory(() => QuoteBloc(random: sl()));
  //* Use cases
  sl.registerLazySingleton(() => GetRandomQuote(sl()));
  //* Repository
  sl.registerLazySingleton<QuoteRepository>(
    () => QuoteRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  //* Data sources
  sl.registerLazySingleton<QuoteRemoteDataSource>(
    () => QuoteRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<QuoteLocalDataSource>(
    () => QuoteLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );
}

void initCore() {
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );
}

Future<void> initExternal() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
}
