import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/home/presentation/pages/AsmaaAllah/cubit/asmaa_hosna_cubit.dart';

import '../../features/Listen/presentation/pages/build_audio_page.dart';
import '../../features/Quran/presentation/pages/quran_page.dart';
import '../../features/Quran/presentation/pages/surah_page.dart';
import '../../features/SplashPage/splash_page.dart';
import '../../features/auth/presentation/pages/forget_password_page.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/register_screen.dart';
import '../../features/home/presentation/pages/AsmaaAllah/asmaa_allah_page.dart';
import '../../features/home/presentation/pages/Hadith/hadith_page.dart';
import '../../features/home/presentation/pages/Sebha/sebha_page.dart';
import '../../features/home/presentation/widgets/about_us.dart';
import '../Animations/slide_left.dart';
import 'routes_name.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.oboardingscreen:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case RoutesName.loginscreen:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case RoutesName.registerscreen:
        return SlideToLeft(page: const RegisterPage());
      case RoutesName.forgetpasswordscreen:
        return SlideToLeft(page: const ForGetPasswordPage());
      case RoutesName.quranPage:
        return SlideToLeft(page: const QuranPage());
      case RoutesName.surahPage:
        return SlideToLeft(page: const SurahPage());
      case RoutesName.sebhaPage:
        return SlideToLeft(page: const SebhaPage());
      case RoutesName.audioPage:
        return SlideToLeft(page: const BuildAudioPage());
      case RoutesName.aboutUs:
        return SlideToLeft(page: const AboutUsPage());
      case RoutesName.hadith:
        return SlideToLeft(page: const HadithPage());
      case RoutesName.doaa:
        return SlideToLeft(
            page: BlocProvider(
          create: (context) => AsmaaHosnaCubit()..getData(),
          child: const AsmaaAllahPage(),
        ));

      default:
        return onUnknownRoute(settings)!;
    }
  }

  static Route? onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("404"),
            centerTitle: true,
          ),
          body: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 100,
                  color: Colors.red,
                ),
                Text(
                  "Page not found",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
