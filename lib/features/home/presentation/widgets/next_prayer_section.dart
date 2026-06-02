import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../../../core/functions/prayer_schedule_helper.dart';
import '../cubit/PrayerCubit/prayer_cubit.dart';
import 'current_prayer_card.dart';
import 'home_prayer_ui.dart';
import 'prayer_time.dart';

class NextPrayerSection extends StatelessWidget {
  const NextPrayerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerCubit, PrayerState>(
      builder: (context, state) {
        if (state is PrayerLoading) {
          return SliverToBoxAdapter(
            child: Container(
              height: HomePrayerUi.heroHeight,
              margin: const EdgeInsetsDirectional.only(
                bottom: HomePrayerUi.itemGap,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(HomePrayerUi.radius),
                color: Colors.grey.withOpacity(0.12),
              ),
            ),
          );
        }

        if (state is! PrayerSuccess) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        final slots = buildPrayerSlots(context, state);
        final l10n = AppLocalizations.of(context)!;

        return SliverToBoxAdapter(
          child: StreamBuilder<PrayerScheduleInfo>(
            stream: prayerScheduleStream(slots),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox(
                  height: HomePrayerUi.heroHeight,
                  child: Center(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                );
              }

              return CurrentPrayerCard(
                schedule: snapshot.data!,
                nextPrayerLabel: l10n.nextPrayer,
                remainingLabel: l10n.timeRemaining,
                currentPrayerLabelBuilder: l10n.currentPrayerPeriod,
              );
            },
          ),
        );
      },
    );
  }
}
