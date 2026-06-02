import 'package:flutter/material.dart';

import '../../config/Animations/slide_left.dart';

extension NavigatorToPage on BuildContext {
  void pop() {
    Navigator.pop(this);
  }

  void push({required Widget widget}) {
    Navigator.push(
      this,
      SlideToLeft(page: widget),
    );
  }

  void pushAndRemoveUntil({required Widget widget}) {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );
  }

  void pushNamed({required String pageRoute}) {
    Navigator.pushNamed(this, pageRoute);
  }

  void pushNamedAndRemoveUntil({required String pageRoute}) {
    Navigator.pushNamedAndRemoveUntil(
      this,
      pageRoute,
      (route) => false,
    );
  }

  void pushReplacement({required Widget widget}) {
    Navigator.pushReplacement(
      this,
      SlideToLeft(page: widget),
    );
  }

  void pushReplacementNamed({required String pageRoute}) {
    Navigator.pushReplacementNamed(
      this,
      pageRoute,
    );
  }
}

extension QueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get width => mediaQuery.size.width;
}
