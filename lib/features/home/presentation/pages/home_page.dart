import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../../../core/widgets/space_widget.dart';
import '../cubit/PrayerCubit/prayer_cubit.dart';
import '../widgets/build_3_icon_widget.dart';
import '../widgets/home_prayer_ui.dart';
import '../widgets/next_prayer_section.dart';
import '../widgets/prayer_time.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return false;
        },
        child: RefreshIndicator(
          onRefresh: () async {
            await context.read<PrayerCubit>().getPrayerTime();
          },
          child: CustomScrollView(
            primary: true,
            slivers: [
              const SpaceWidget(height: 8),
              const NextPrayerSection(),
              const SpaceWidget(height: HomePrayerUi.sectionTitleGap),
              const Build3IconWidget(),
              const SpaceWidget(height: HomePrayerUi.sectionTitleGap),
              BlocBuilder<PrayerCubit, PrayerState>(
                builder: (context, state) {
                  if (state is PrayerLoading) {
                    return SliverList.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Container(
                          height: HomePrayerUi.listRowHeight,
                          margin: const EdgeInsetsDirectional.only(
                            bottom: HomePrayerUi.itemGap,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              HomePrayerUi.radius,
                            ),
                            border: Border.all(
                              color: Colors.indigo.withOpacity(0.25),
                            ),
                          ),
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
