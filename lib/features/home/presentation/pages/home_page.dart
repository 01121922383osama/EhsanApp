import 'package:flutter/material.dart';
import 'package:free_lancer/features/home/presentation/widgets/prayer_time.dart';

import '../../../../core/widgets/space_widget.dart';
import '../widgets/build_3_icon_widget.dart';

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
          child: const CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SpaceWidget(),
              Build3IconWidget(),
              SpaceWidget(height: 35),
              PrayerTime(),
              SpaceWidget(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
