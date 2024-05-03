import 'package:flutter/material.dart';

class SlideToLeft extends PageRouteBuilder {
  final Widget page;
  SlideToLeft({
    required this.page,
  }) : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation1),
              child: child,
            );
          },
        );
}
