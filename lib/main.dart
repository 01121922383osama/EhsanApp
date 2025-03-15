import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'config/routes/routes.dart';
import 'config/routes/routes_name.dart';
import 'config/theme/app_theme.dart';
import 'features/Setting/presentation/cubit/ChangeFonts/change_fonts.dart';
import 'features/Setting/presentation/cubit/Lang/change_language_cubit.dart';
import 'features/Setting/presentation/cubit/Theme/theme_cubit.dart';
import 'features/app/presentation/cubit/app_cubit.dart';
import 'features/home/presentation/cubit/GetNextPrayerTime/get_next_prayer_time_cubit.dart';
import 'features/home/presentation/cubit/PrayerCubit/prayer_cubit.dart';
import 'features/home/presentation/pages/Azkar/cubit/azkar_cubit.dart';
import 'injection_container.dart' as di;
import 'observer_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = MyBlocObserver();
  runApp(const QuranApp());
}

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChangeFonts(), lazy: true),
        BlocProvider(
          create: (context) => AzkarCubit()..getZekrData(),
          lazy: true,
        ),
        BlocProvider(create: (context) => ChangeLanguageCubit(), lazy: true),
        BlocProvider(create: (context) => ThemeCubit(), lazy: true),
        BlocProvider(create: (context) => AppCubit(), lazy: true),
        BlocProvider(
          create: (context) => di.sl<PrayerCubit>()..getPrayerTime(),
        ),
        BlocProvider(
          create: (context) =>
              di.sl<GetNextPrayerTimeCubit>()..getNextPrayerTime(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, theme) {
          return BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
            builder: (context, lang) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                darkTheme: AppTheme.dark,
                theme: AppTheme.light,
                themeMode: theme ? ThemeMode.dark : ThemeMode.light,
                locale: Locale(lang.lang),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                initialRoute: RoutesName.oboardingscreen,
                onGenerateRoute: AppRoute.onGenerateRoute,
                onUnknownRoute: AppRoute.onUnknownRoute,
              );
            },
          );
        },
      ),
    );
  }
}
