import 'package:flutter/material.dart';

import '../extension/extension.dart';
import '../utils/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  final String textButton;
  final void Function() onPressed;
  const CustomIconButton(
      {super.key, required this.textButton, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.all(0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.center,
        minimumSize: Size(context.width * 0.9, context.width * 0.150),
      ),
      onPressed: onPressed,
      child: Text(textButton),
    );
  }
}
