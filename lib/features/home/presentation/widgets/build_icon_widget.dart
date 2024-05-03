import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class BuildIconWidget extends StatelessWidget {
  final String image;
  final String text;
  final void Function()? onTap;
  const BuildIconWidget(
      {super.key, required this.image, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: AppColors.grey.withOpacity(0.5),
              offset: const Offset(0, 5),
            ),
            BoxShadow(
              blurRadius: 5,
              color: AppColors.grey.withOpacity(0.5),
              offset: const Offset(5, 0),
            ),
            BoxShadow(
              blurRadius: 5,
              color: AppColors.grey.withOpacity(0.5),
              offset: const Offset(-5, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(image),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
