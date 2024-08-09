import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../config/routes/routes_name.dart';
import '../../../../core/extension/extension.dart';
import 'build_icon_widget.dart';

class Build3IconWidget extends StatelessWidget {
  const Build3IconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BuildIconWidget(
              image: 'assets/images/sebha.png',
              text: AppLocalizations.of(context)!.sebha,
              onTap: () {
                SystemChrome.setPreferredOrientations(
                  [DeviceOrientation.portraitUp],
                );
                context.pushNamed(pageRoute: RoutesName.sebhaPage);
              },
            ).animate().fade(),
            BuildIconWidget(
              image: 'assets/images/doaa.png',
              text: AppLocalizations.of(context)!.azkar,
              onTap: () {
                context.pushNamed(pageRoute: RoutesName.hadith);
              },
            ).animate().fade(),
            BuildIconWidget(
              image: 'assets/images/hadith.png',
              text: AppLocalizations.of(context)!.doaa,
              onTap: () {
                context.pushNamed(pageRoute: RoutesName.doaa);
              },
            ).animate().fade(),
          ],
        ),
      ),
    );
  }
}
