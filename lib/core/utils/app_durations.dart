import 'package:flutter/widgets.dart';

/// Shared fast animation timings across the app.
abstract final class AppDurations {
  static const animation = Duration(milliseconds: 100);
  static const pageTransition = animation;
  static const pageScroll = animation;
  static const micro = Duration(milliseconds: 150);
}

/// Snappier PageView swipe / snap than the default physics.
class FastPageScrollPhysics extends PageScrollPhysics {
  const FastPageScrollPhysics({super.parent});

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 0.35,
        stiffness: 640,
        damping: 30,
      );

  @override
  FastPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return FastPageScrollPhysics(parent: buildParent(ancestor));
  }
}
