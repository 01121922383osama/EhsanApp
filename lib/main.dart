import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:free_lancer/features/app/presentation/cubit/app_cubit.dart';

import 'config/routes/routes.dart';
import 'config/routes/routes_name.dart';
import 'config/theme/app_theme.dart';
import 'features/Setting/presentation/cubit/ChangeFonts/change_fonts.dart';
import 'features/Setting/presentation/cubit/Lang/change_language_cubit.dart';
import 'features/Setting/presentation/cubit/Theme/theme_cubit.dart';
import 'features/home/presentation/pages/Azkar/cubit/azkar_cubit.dart';
import 'features/home/presentation/pages/Sebha/cubit/list_of_sabeh_cubit.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
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
            create: (context) => AzkarCubit()..getZekrData(), lazy: true),
        BlocProvider(create: (context) => ListOfSabehCubit(), lazy: true),
        BlocProvider(create: (context) => ChangeLanguageCubit(), lazy: true),
        BlocProvider(create: (context) => ThemeCubit(), lazy: true),
        BlocProvider(create: (context) => AppCubit(), lazy: true),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, state) {
          return BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
            builder: (context, lang) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                darkTheme: AppTheme.dark,
                theme: AppTheme.light,
                themeMode: state ? ThemeMode.dark : ThemeMode.light,
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
