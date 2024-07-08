import 'package:flutter/material.dart';

extension ScreenUtils on BuildContext {
  Size get size => MediaQuery.sizeOf(this);
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
  bool get isMobile => width < 450;
  bool get isTablet => width >= 450 && width < 1100;
  bool get isDesktop => width >= 1100;
}
