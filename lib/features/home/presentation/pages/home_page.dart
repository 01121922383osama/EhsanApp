import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/utils/app_colors.dart';
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
    return Scaffold(
      body: Padding(
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
              BlocProvider(
                create: (context) => di.sl<PrayerCubit>()..getPrayerTime(),
                child: BlocBuilder<PrayerCubit, PrayerState>(
                  builder: (context, state) {
                    if (state is PrayerLoading) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text(AppLocalizations.of(context)!.loading),
                        ),
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
                                  color: AppColors.red,
                                ),
                              ),
                              const SizedBox(height: 25),
                              TextButton(
                                onPressed: () {
                                  context.read<PrayerCubit>().getPrayerTime();
                                },
                                child: Text(
                                    AppLocalizations.of(context)!.tryAgain),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const PrayerTime();
                  },
                ),
              ),
              const SpaceWidget(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
