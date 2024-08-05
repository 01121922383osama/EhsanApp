import 'package:flutter/material.dart';
import 'package:free_lancer/core/extension/blurry_widget.dart';
import 'package:free_lancer/core/utils/app_colors.dart';
import 'package:free_lancer/core/utils/app_styles.dart';

class DetailsAmaaHosna extends StatelessWidget {
  final int index;
  final String name;
  final String text;
  const DetailsAmaaHosna({
    super.key,
    required this.index,
    required this.name,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: AlignmentDirectional.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Chip(
            label: Text(
              name,
              style: AppTextStyles.textStyleFont20.copyWith(
                color: AppColors.white,
              ),
            ),
            color: WidgetStatePropertyAll(AppColors.red.withOpacity(0.5)),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(width: 0.8),
            ),
            color: AppColors.white.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: AppTextStyles.textStyleFont15WoColor.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ).blurry(blur: 15),
    );
  }
}
