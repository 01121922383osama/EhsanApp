import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../Setting/presentation/cubit/Theme/theme_cubit.dart';
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
          color: AppColors.lightgray.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.listen,
                    style: TextStyle(
                      color: context.read<ThemeCubit>().state
                          ? AppColors.white
                          : AppColors.darkBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Expanded(
                    child: MusicVisualizer(
                      curve: Curves.easeInOutQuart,
                      barCount: 50,
                      colors: [
                        AppColors.darkBlue,
                        AppColors.lightgray,
                        AppColors.grey,
                        AppColors.red,
                        AppColors.primary,
                        AppColors.redDart,
                        AppColors.lightblue,
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
              style: TextStyle(
                color: context.read<ThemeCubit>().state
                    ? AppColors.white.withOpacity(0.5)
                    : AppColors.darkBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
