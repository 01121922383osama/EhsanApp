import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/space_widget.dart';
import '../../../../injection_container.dart' as di;
import '../cubit/PrayerCubit/prayer_cubit.dart';
import '../widgets/build_3_icon_widget.dart';
import '../widgets/prayer_time.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<PrayerCubit>()..getPrayerTime(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: CustomScrollView(
            primary: true,
            slivers: [
              const SpaceWidget(),
              const Build3IconWidget(),
              const SpaceWidget(height: 30),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.prayerTimes,
                      style: AppTextStyles.textStyleFont15WoColor,
                    ),
                  ],
                ),
              ),
              BlocBuilder<PrayerCubit, PrayerState>(
                builder: (context, state) {
                  if (state is PrayerLoading) {
                    return SliverList.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.indigo.withOpacity(0.4),
                            ),
                          ),
                          child: const ListTile(),
                        ).animate(
                          onComplete: (controller) {
                            controller.repeat();
                          },
                        )..shimmer(
                            delay: const Duration(milliseconds: 800),
                          );
                      },
                    );
                  }
                  if (state is PrayerFailure) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 60 * 1.5),
                            Text(
                              AppLocalizations.of(context)!.checkInternet,
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 25),
                            TextButton(
                              onPressed: () {
                                context.read<PrayerCubit>().getPrayerTime();
                              },
                              child:
                                  Text(AppLocalizations.of(context)!.tryAgain),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const PrayerTime();
                },
              ),
              const SpaceWidget(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
