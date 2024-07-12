import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'config/routes/routes.dart';
import 'config/routes/routes_name.dart';
import 'config/theme/app_theme.dart';
import 'features/Setting/presentation/cubit/Lang/change_language_cubit.dart';
import 'features/Setting/presentation/cubit/Theme/theme_cubit.dart';
import 'features/app/presentation/cubit/app_cubit.dart';
import 'features/home/presentation/pages/Hadith/cubit/azkar_cubit.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AzkarCubit()..getZekrData(),
      child: BlocProvider(
        create: (context) => AppCubit(),
        child: BlocProvider(
          create: (context) => ChangeLanguageCubit(),
          child: BlocProvider(
            create: (context) => ThemeCubit(),
            child: BlocBuilder<ThemeCubit, bool>(
              builder: (context, state) {
                return BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
                  builder: (context, lang) {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      darkTheme: ThemeData.dark(useMaterial3: true),
                      themeMode: state ? ThemeMode.dark : ThemeMode.light,
                      theme: AppTheme.themeData,
                      locale: Locale(lang.lang),
                      localizationsDelegates:
                          AppLocalizations.localizationsDelegates,
                      supportedLocales: AppLocalizations.supportedLocales,
                      initialRoute: RoutesName.oboardingscreen,
                      onGenerateRoute: AppRoute.onGenerateRoute,
                      onUnknownRoute: AppRoute.onUnknownRoute,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
