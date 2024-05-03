import 'package:flutter/material.dart';

import '../../../../config/routes/routes_name.dart';
import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';
import 'build_icon_widget.dart';

class Build3IconWidget extends StatelessWidget {
  const Build3IconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.lightgray,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BuildIconWidget(
              image: 'assets/images/sebha.png',
              text: 'Sebha',
              onTap: () {
                context.pushNamed(pageRoute: RoutesName.sebhaPage);
              },
            ),
            const BuildIconWidget(
              image: 'assets/images/hadith.png',
              text: 'Hadith',
            ),
            const BuildIconWidget(
              image: 'assets/images/doaa.png',
              text: 'Doaa',
            ),
          ],
        ),
      ),
    );
  }
}
