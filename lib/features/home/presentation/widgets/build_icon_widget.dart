import 'package:flutter/material.dart';

import '../../../../core/utils/app_styles.dart';
import 'home_prayer_ui.dart';

class BuildIconWidget extends StatelessWidget {
  const BuildIconWidget({
    super.key,
    required this.image,
    required this.text,
    required this.accentColor,
    this.onTap,
  });

  final String image;
  final String text;
  final Color accentColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final onColor = HomePrayerUi.readableOn(accentColor);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(HomePrayerUi.radius),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(HomePrayerUi.radius),
            gradient: LinearGradient(
              colors: [
                accentColor.withOpacity(0.48),
                accentColor.withOpacity(0.22),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            border: Border.all(
              color: accentColor.withOpacity(0.48),
              width: 0.9,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                image,
                height: 24,
                width: 24,
              ),
              const SizedBox(height: 4),
              Text(
                text,
                style: AppTextStyles.textStyleFont13.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: onColor,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
