import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/Network/network_info.dart';
import 'core/api/api_consumer.dart';
import 'core/api/api_enterseptor.dart';
import 'core/api/dio_consumer.dart';
import 'features/Quran/data/datasources/LocalDataSource/quran_local_datasource.dart';
import 'features/Quran/data/datasources/RemoteDataSource/quran_remote_datasource.dart';
import 'features/Quran/data/repositories/quran_repo_impl.dart';
import 'features/Quran/domain/repositories/quran_repo.dart';
import 'features/Quran/domain/usecases/get_all_quran_use_cases.dart';
import 'features/Quran/presentation/cubit/quran_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // cubit
  sl.registerFactory(() => QuranCubit(getAllQuranUseCases: sl.call()));
  // repository
  sl.registerLazySingleton<QuranRepo>(() => QuranRepoImpl(
        networkInfo: sl.call(),
        quranLocalDataSource: sl.call(),
        quranRemoteDataSource: sl.call(),
      ));
  // usecases
  sl.registerLazySingleton(() => GetAllQuranUseCases(quranRepo: sl.call()));
  // data sources
  sl.registerLazySingleton<QuranRemoteDataSource>(
      () => QuranRemoteDataSourceImpl(apiConsumerService: sl.get()));
  sl.registerLazySingleton<QuranLocalDataSource>(
      () => QuranLocalDataSourceImpl());
  // external
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl.call()));
  sl.registerLazySingleton<ApiConsumerService>(
      () => DioConsumer(client: sl.call()));
  sl.registerLazySingleton(() => AppIntercepters());
  sl.registerLazySingleton(() => LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ));
}
