import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../../../core/utils/app_durations.dart';
import 'listen_ui.dart';
import 'sound_effect.dart';

class BuildFirstWidget extends StatelessWidget {
  const BuildFirstWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
      sliver: SliverToBoxAdapter(
        child: ListenUi.heroCard(
          context,
          title: l10n.listen,
          subtitle: l10n.listToQuran,
          visualizer: MusicVisualizer(
            curve: Curves.easeInOutCubic,
            barCount: 48,
            colors: [
              scheme.primary,
              scheme.primary.withOpacity(0.65),
              scheme.secondary.withOpacity(0.55),
              scheme.outline.withOpacity(0.45),
            ],
            duration: const [900, 1200, 1500, 1100],
          ),
        )
            .animate()
            .fadeIn(duration: AppDurations.animation)
            .slideY(begin: 0.04, end: 0, duration: AppDurations.animation),
      ),
    );
  }
}
