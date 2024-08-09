import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'sound_effect.dart';

class BuildFirstWidget extends StatelessWidget {
  const BuildFirstWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.listen,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Expanded(
                    child: MusicVisualizer(
                      curve: Curves.easeInOutQuart,
                      barCount: 50,
                      colors: [
                        Color(0xFF3F4871),
                        Color(0xFFE8ECFF),
                        Color(0xFF9E9E9E),
                        Color(0xFFD84C59),
                        Color(0xFF5768E0),
                        Color(0xFF74080C),
                        Color(0xFFE8ECFF),
                      ],
                      duration: [
                        1000,
                        2000,
                        3000,
                        4000,
                        5000,
                        6000,
                        7000,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.listToQuran,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ).animate().flip(),
    );
  }
}
