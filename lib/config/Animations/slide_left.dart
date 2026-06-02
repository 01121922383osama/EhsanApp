import 'package:flutter/material.dart';

import '../../core/utils/app_durations.dart';

class SlideToLeft extends PageRouteBuilder {
  SlideToLeft({
    required Widget page,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: AppDurations.pageTransition,
          reverseTransitionDuration: AppDurations.pageTransition,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            );
          },
        );
}
