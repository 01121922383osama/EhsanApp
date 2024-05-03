import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../widgets/build_first_widget.dart';
import '../widgets/build_menu_alshai5.dart';

class ListenPage extends StatelessWidget {
  const ListenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: const CustomScrollView(
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              BuildFirstWidget(),
              SliverToBoxAdapter(
                child: Text(
                  'Most Popular',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              BuildMenuShai5(),
            ],
          ),
        ),
      ),
    );
  }
}
