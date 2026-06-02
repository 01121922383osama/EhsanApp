import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/extension/extension.dart';
import '../../../../../../core/utils/app_durations.dart';
import '../../widgets/home_feature_ui.dart';
import 'cubit/azkar_cubit.dart';
import 'details_of_zek.dart';

class BodyAzkarPage extends StatelessWidget {
  const BodyAzkarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AzkarCubit, AzkarState>(
      builder: (context, state) {
        if (state is AzkarSuccess) {
          final azkar = state.azkar;
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: HomeFeatureUi.pagePadding,
            cacheExtent: 1000,
            itemCount: azkar.length,
            itemBuilder: (context, index) {
              final zekr = azkar[index];
              return HomeFeatureUi.categoryTile(
                context: context,
                index: index,
                title: zekr.category,
                onTap: () {
                  context.push(
                    widget: DetailsOfZekr(
                      title: zekr.category,
                      zekr: zekr.array,
                    ),
                  );
                },
              )
                  .animate(delay: (30 * index).ms)
                  .fadeIn(duration: AppDurations.animation)
                  .slideX(begin: 0.04, end: 0, duration: AppDurations.animation);
            },
          );
        }

        return HomeFeatureUi.compactLoading();
      },
    );
  }
}
