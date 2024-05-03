import 'package:flutter/material.dart';

import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';
import 'sound_effect.dart';

class BuildFirstWidget extends StatelessWidget {
  const BuildFirstWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: AppColors.transparent,
      shadowColor: AppColors.transparent,
      foregroundColor: AppColors.transparent,
      elevation: 0,
      surfaceTintColor: AppColors.transparent,
      toolbarHeight: context.height * 0.15,
      flexibleSpace: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.lightgray.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Text(
                    'Listen',
                    style: TextStyle(
                      color: AppColors.darkBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  MusicVisualizer(
                    barCount: 80,
                    colors: [
                      AppColors.darkBlue,
                      AppColors.lightgray,
                      AppColors.grey,
                      AppColors.backgroundScaffold,
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
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              '''Listen to the Holy Qur’an, listen to religious podcasts, may Allah grant your success.''',
              style: TextStyle(
                color: AppColors.darkBlue,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
