import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_lancer/core/utils/app_colors.dart';
import 'package:free_lancer/features/home/presentation/cubit/PrayerCubit/prayer_cubit.dart';
import 'package:intl/intl.dart';

class PrayerTime extends StatelessWidget {
  const PrayerTime({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const Text(
            'Prayer Times in  Cairo',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          GridView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.5,
            ),
            cacheExtent: 10000,
            children: [
              for (int i = 0; i < 6; i++)
                BlocBuilder<PrayerCubit, PrayerState>(
                  builder: (context, state) {
                    if (state is PrayerLoading) {
                      return const SizedBox.shrink();
                    } else if (state is PrayerSuccess) {
                      final List<DateTime> time = [
                        state.prayerTime.fajr,
                        state.prayerTime.sunrise,
                        state.prayerTime.dhuhr,
                        state.prayerTime.asr,
                        state.prayerTime.maghrib,
                        state.prayerTime.isha,
                      ];
                      return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.lightblue,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.lightgray,
                              spreadRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _arabicPrayer[i],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '(  ${DateFormat().add_jmz().format(time[i])}  )',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// List<String> _prayer = [
//   'Fajr',
//   'Sunrise',
//   'Dhuhr',
//   'Asr',
//   'Maghrib',
//   'Isha',
// ];
List<String> _arabicPrayer = [
  'الفجر',
  'الشروق',
  'الظهر',
  'العصر',
  'المغرب',
  'العشاء',
];
