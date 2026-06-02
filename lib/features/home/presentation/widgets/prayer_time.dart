import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_lancer/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../core/functions/prayer_schedule_helper.dart';
import '../cubit/PrayerCubit/prayer_cubit.dart';
import 'anim_prayer_time.dart';
import 'home_prayer_ui.dart';

List<String> arabicPrayer(BuildContext context) => [
      AppLocalizations.of(context)!.fajr,
      AppLocalizations.of(context)!.sunrise,
      AppLocalizations.of(context)!.dhuhr,
      AppLocalizations.of(context)!.asr,
      AppLocalizations.of(context)!.maghrib,
      AppLocalizations.of(context)!.isha,
    ];

List<PrayerSlot> buildPrayerSlots(BuildContext context, PrayerSuccess state) {
  final names = arabicPrayer(context);
  final times = prayerTimesToday(state);
  const images = [
    'assets/images/fajr.png',
    'assets/images/shrooq.png',
    'assets/images/zhur.png',
    'assets/images/asr.png',
    'assets/images/magrib.png',
    'assets/images/isyah.png',
  ];

  return List.generate(
    6,
    (i) => PrayerSlot(name: names[i], time: times[i], imageAsset: images[i]),
  );
}

List<DateTime> prayerTimesToday(PrayerSuccess state) => [
      prayerTimeOnToday(state.prayerTime.fajr),
      prayerTimeOnToday(state.prayerTime.sunrise),
      prayerTimeOnToday(state.prayerTime.dhuhr),
      prayerTimeOnToday(state.prayerTime.asr),
      prayerTimeOnToday(state.prayerTime.maghrib),
      prayerTimeOnToday(state.prayerTime.isha),
    ];

class PrayerTime extends StatelessWidget {
  const PrayerTime({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerCubit, PrayerState>(
      builder: (context, state) {
        if (state is! PrayerSuccess) {
          return SliverToBoxAdapter(
            child: Center(child: Text(AppLocalizations.of(context)!.loading)),
          );
        }

        final times = prayerTimesToday(state);
        final slots = buildPrayerSlots(context, state);
        final timeFormat = DateFormat().add_jmz();
        final l10n = AppLocalizations.of(context)!;

        return StreamBuilder<PrayerScheduleInfo>(
          stream: prayerScheduleStream(slots),
          builder: (context, scheduleSnapshot) {
            final nextIndex = scheduleSnapshot.data?.nextIndex ?? 0;

            return SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: HomePrayerUi.sectionTitle(context, l10n.prayerTimes),
                ),
                SliverList.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return AnimPrayerTime(
                      index: index,
                      image: slots[index].imageAsset,
                      time: timeFormat.format(times[index]),
                      prayerName: arabicPrayer(context)[index],
                      isNext: index == nextIndex,
                    )
                        .animate(delay: (30 * index).ms)
                        .fadeIn(duration: 50.ms)
                        .slideX(
                          begin: 0.04,
                          end: 0,
                          duration: 50.ms,
                          curve: Curves.easeOutCubic,
                        );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
