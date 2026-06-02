import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../../../config/routes/routes_name.dart';
import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_durations.dart';
import 'build_icon_widget.dart';
import 'home_prayer_ui.dart';

class Build3IconWidget extends StatelessWidget {
  const Build3IconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = [
      _QuickActionItem(
        image: 'assets/images/sebha.png',
        label: l10n.sebha,
        color: AppColors.paryersTime[0],
        onTap: () {
          SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp],
          );
          context.pushNamed(pageRoute: RoutesName.sebhaPage);
        },
      ),
      _QuickActionItem(
        image: 'assets/images/doaa.png',
        label: l10n.azkar,
        color: AppColors.paryersTime[2],
        onTap: () => context.pushNamed(pageRoute: RoutesName.hadith),
      ),
      _QuickActionItem(
        image: 'assets/images/hadith.png',
        label: l10n.doaa,
        color: AppColors.paryersTime[5],
        onTap: () => context.pushNamed(pageRoute: RoutesName.doaa),
      ),
    ];

    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(HomePrayerUi.radius),
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.12),
          ),
        ),
        child: Row(
          children: [
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0) const SizedBox(width: HomePrayerUi.itemGap),
              Expanded(
                child: BuildIconWidget(
                  image: items[i].image,
                  text: items[i].label,
                  accentColor: items[i].color,
                  onTap: items[i].onTap,
                )
                    .animate(delay: (50 * i).ms)
                    .fadeIn(duration: AppDurations.animation)
                    .scale(
                      begin: const Offset(0.96, 0.96),
                      end: const Offset(1, 1),
                      duration: AppDurations.animation,
                      curve: Curves.easeOutCubic,
                    ),
              ),
            ],
          ],
        ),
      )
          .animate()
          .fadeIn(duration: AppDurations.animation)
          .slideY(begin: 0.04, end: 0, duration: AppDurations.animation),
    );
  }
}

class _QuickActionItem {
  const _QuickActionItem({
    required this.image,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String image;
  final String label;
  final Color color;
  final VoidCallback onTap;
}
