import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class PaintLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = AppColors.darkBlue;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 23, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
