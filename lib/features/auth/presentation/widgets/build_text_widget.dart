import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';

class BuildTextWidget extends StatelessWidget {
  final String text1;
  final String text2;

  const BuildTextWidget({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: context.width / 15, top: 20),
      decoration: BoxDecoration(
        color: AppColors.lightgray.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text1,
            style: const TextStyle(
              color: AppColors.darkBlue,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            text2,
            style: TextStyle(
              color: AppColors.black.withOpacity(0.5),
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
