import 'package:dio/dio.dart';
import 'package:free_lancer/features/home/data/datasources/prayer_local_datasource.dart';
import 'package:free_lancer/features/home/data/datasources/prayer_remote_datasource.dart';
import 'package:free_lancer/features/home/data/repositories/prayer_time_imple.dart';
import 'package:free_lancer/features/home/domain/repositories/prayer_time_repo.dart';
import 'package:free_lancer/features/home/domain/usecases/prayer_time_usecases.dart';
import 'package:free_lancer/features/home/presentation/cubit/PrayerCubit/prayer_cubit.dart';
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
  sl.registerFactory(() => PrayerCubit(prayerTimeUseCases: sl.call()));
  // repository
  sl.registerLazySingleton<QuranRepo>(() => QuranRepoImpl(
        networkInfo: sl.call(),
        quranLocalDataSource: sl.call(),
        quranRemoteDataSource: sl.call(),
      ));
  sl.registerLazySingleton<PrayerTimeRepo>(() => PrayerTimeImple(
        networkInfo: sl.call(),
        localDataSource: sl.call(),
        remoteDataSource: sl.call(),
      ));
  // usecases
  sl.registerLazySingleton(() => GetAllQuranUseCases(quranRepo: sl.call()));
  sl.registerLazySingleton(() => PrayerTimeUseCases(prayerTimeRepo: sl.call()));
  // data sources
  sl.registerLazySingleton<QuranRemoteDataSource>(
      () => QuranRemoteDataSourceImpl(apiConsumerService: sl.get()));
  sl.registerLazySingleton<QuranLocalDataSource>(
      () => QuranLocalDataSourceImpl());
  sl.registerLazySingleton<PrayerRemoteDataSource>(
      () => PrayerRemoteDataSourceImpl(apiConsumerService: sl.call()));
  sl.registerLazySingleton<PrayerTimeLocalDataSource>(
      () => PrayerTimeLocalDataSourceImpl());
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
