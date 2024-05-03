import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_lancer/features/home/presentation/cubit/PrayerCubit/prayer_cubit.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'config/routes/routes.dart';
import 'config/routes/routes_name.dart';
import 'config/theme/app_theme.dart';
import 'features/Listen/presentation/cubit/listen_cubit.dart';
import 'features/Quran/presentation/cubit/quran_cubit.dart';
import 'features/app/presentation/cubit/app_cubit.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  await di.init();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => ListenCubit(),
        ),
        BlocProvider(
          create: (context) => di.sl<QuranCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<PrayerCubit>()..getPrayerTime(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'إحـسـان',
        theme: AppTheme.themeData,
        initialRoute: RoutesName.oboardingscreen,
        onGenerateRoute: AppRoute.onGenerateRoute,
        onUnknownRoute: AppRoute.onUnknownRoute,
      ),
    );
  }
}
