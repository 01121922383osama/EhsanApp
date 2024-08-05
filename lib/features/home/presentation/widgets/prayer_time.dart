import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../core/functions/remaining_time.dart';
import '../../../../core/utils/app_styles.dart';
import '../cubit/PrayerCubit/prayer_cubit.dart';
import 'anim_prayer_time.dart';

class PrayerTime extends StatelessWidget {
  const PrayerTime({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return BlocBuilder<PrayerCubit, PrayerState>(
          builder: (context, state) {
            if (state is PrayerSuccess) {
              final List<DateTime> time = [
                state.prayerTime.fajr,
                state.prayerTime.sunrise,
                state.prayerTime.dhuhr,
                state.prayerTime.asr,
                state.prayerTime.maghrib,
                state.prayerTime.isha,
              ];
              List<String> images = [
                'assets/images/fajr.png',
                'assets/images/shrooq.png',
                'assets/images/zhur.png',
                'assets/images/asr.png',
                'assets/images/magrib.png',
                'assets/images/isyah.png',
              ];
              return AnimPrayerTime(
                index: index,
                image: images[index],
                time: DateFormat().add_jmz().format(time[index]),
                prayerName: _arabicPrayer(context)[index],
                widget: StreamBuilder(
                  stream: remainingTime(time[index]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        '  ${snapshot.data}',
                        style: AppTextStyles.textStyleFont16,
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              );
            } else {
              return Center(
                child: Text(AppLocalizations.of(context)!.loading),
              );
            }
          },
        );
      },
    );
  }
}

List<String> _arabicPrayer(BuildContext context) => [
      AppLocalizations.of(context)!.fajr,
      AppLocalizations.of(context)!.sunrise,
      AppLocalizations.of(context)!.dhuhr,
      AppLocalizations.of(context)!.asr,
      AppLocalizations.of(context)!.maghrib,
      AppLocalizations.of(context)!.isha,
    ];
