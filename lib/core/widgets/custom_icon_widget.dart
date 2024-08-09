import 'package:flutter/material.dart';

import '../extension/extension.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomIconButton extends StatelessWidget {
  final String textButton;
  final void Function() onPressed;
  const CustomIconButton(
      {super.key, required this.textButton, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // backgroundColor: AppColors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
        textStyle: AppTextStyles.textStyleFont20,
         padding: const EdgeInsets.all(0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.center,
        minimumSize: Size(context.width * 0.9, 65),
      ),
      onPressed: onPressed,
      child: Text(textButton),
    );
  }
}
