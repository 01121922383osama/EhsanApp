import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

import '../../../../core/widgets/custom_search.dart';
import '../../../../core/widgets/space_widget.dart';
import '../../../../core/widgets/build_leading_widget.dart';
import '../widgets/build_sora_widget.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const BuildIconBackWidget(),
              CustomSearchWidget(
                hintText: 'Search for Surah...',
                color: AppColors.grey.withOpacity(0.5),
                onChanged: (value) {},
              ),
              Expanded(
                child: Scrollbar(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overScroll) {
                      overScroll.disallowIndicator();
                      return false;
                    },
                    child: const CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SpaceWidget(height: 20),
                        BuildSoraNamesWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
