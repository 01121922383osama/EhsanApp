import 'package:flutter/material.dart';
import '../widgets/blurry_container.dart';

extension BlurryWidget<T extends Widget> on T {
  Widget blurry({
    double? height,
    double? width,
    double blur = 5,
    double elevation = 0,
    EdgeInsets padding = const EdgeInsets.all(8),
    Color color = Colors.transparent,
    Color shadowColor = Colors.black26,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8)),
  }) {
    return BlurryContainer(
      height: height,
      width: width,
      blur: blur,
      elevation: elevation,
      color: color,
      shadowColor: shadowColor,
      borderRadius: borderRadius,
      child: this,
    );
  }
}
