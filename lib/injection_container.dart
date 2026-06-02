import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'core/Network/network_info.dart';
import 'core/api/api_consumer.dart';
import 'core/api/api_enterseptor.dart';
import 'core/api/dio_consumer.dart';
import 'core/constants/constants.dart';
import 'core/utils/app_strings.dart';
import 'features/home/data/datasources/prayer_local_datasource.dart';
import 'features/home/data/datasources/prayer_remote_datasource.dart';
import 'features/home/data/models/custom_zekr_model.dart';
import 'features/home/data/repositories/prayer_time_imple.dart';
import 'features/home/domain/entities/prayer_time_entity.dart';
import 'features/home/domain/repositories/prayer_time_repo.dart';
import 'features/home/domain/usecases/prayer_time_usecases.dart';
import 'features/home/presentation/cubit/GetNextPrayerTime/get_next_prayer_time_cubit.dart';
import 'features/home/presentation/cubit/PrayerCubit/prayer_cubit.dart';
import 'features/Listen/data/services/quran_audio_service.dart';
import 'features/Listen/data/services/youtube_video_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  sl.registerLazySingleton(QuranAudioService.new);
  sl.registerLazySingleton(YoutubeVideoService.new);
  await Hive.initFlutter();
  Hive.registerAdapter(PrayerTimeEntityAdapter());
  await Hive.openBox<PrayerTimeEntity>(AppString.keyPrayerTime);
  await Hive.openBox(AppString.themeMode);
  await Hive.openBox(AppString.changeLang);
  await Hive.openBox(AppString.changeFonts);
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(CustomZekrModelAdapter());
  await Hive.openBox<CustomZekrModel>(AppConstants.customZekrBox);

  // cubit

  sl.registerFactory(() => PrayerCubit(prayerTimeUseCases: sl.call()));
  sl.registerFactory(
      () => GetNextPrayerTimeCubit(prayerTimeUseCases: sl.call()));
  // repository

  sl.registerLazySingleton<PrayerTimeRepo>(() => PrayerTimeImple(
        networkInfo: sl.call(),
        localDataSource: sl.call(),
        remoteDataSource: sl.call(),
      ));
  // usecases
  sl.registerLazySingleton(() => PrayerTimeUseCases(prayerTimeRepo: sl.call()));
  // data sources

  sl.registerLazySingleton<PrayerRemoteDataSource>(
      () => PrayerRemoteDataSourceImpl(apiConsumerService: sl.call()));
  sl.registerLazySingleton<PrayerTimeLocalDataSource>(
      () => PrayerTimeLocalDataSourceImpl());
  // external
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl.call()));
  sl.registerLazySingleton<ApiConsumerService>(
      () => DioConsumer(client: sl.call()));
  sl.registerLazySingleton(() => AppIntercepters());
  sl.registerLazySingleton(() {
    final Dio dio = Dio();
    dio.options.followRedirects = true;
    return LogInterceptor(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    );
  });
}
