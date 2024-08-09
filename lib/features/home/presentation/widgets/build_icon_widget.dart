import 'package:flutter/material.dart';

import '../../../../core/utils/app_styles.dart';

class BuildIconWidget extends StatelessWidget {
  final String image;
  final String text;
  final void Function()? onTap;
  const BuildIconWidget({
    super.key,
    required this.image,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(),
        ),
        child: Column(
          children: [
            Image.asset(image),
            const SizedBox(height: 2),
            FittedBox(
              child: Text(
                text,
                style: AppTextStyles.textStyleFont10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
