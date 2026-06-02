import 'package:flutter/material.dart';

/// Shared dense layout tokens for home prayer / quick-action cards.
abstract final class HomePrayerUi {
  static const double radius = 10;
  static const double listRowHeight = 52;
  static const double heroHeight = 56;
  static const double itemGap = 4;
  static const double sectionTitleGap = 6;
  static const double horizontalInset = 12;
  static const double listIconSize = 26;
  static const double heroIconSize = 30;

  static Color readableOn(Color base) =>
      base.computeLuminance() > 0.55 ? Colors.black87 : Colors.white;

  static BoxDecoration prayerCardDecoration({
    required Color prayerColor,
    required bool highlighted,
    bool withShadow = false,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      gradient: LinearGradient(
        colors: [
          prayerColor.withOpacity(highlighted ? 0.52 : 0.36),
          prayerColor.withOpacity(highlighted ? 0.26 : 0.16),
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      border: Border.all(
        color: prayerColor.withOpacity(highlighted ? 0.62 : 0.42),
        width: highlighted ? 1.1 : 0.9,
      ),
      boxShadow: withShadow
          ? [
              BoxShadow(
                color: prayerColor.withOpacity(0.22),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ]
          : null,
    );
  }

  static Widget sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: sectionTitleGap, top: 2),
      child: Row(
        children: [
          Icon(
            Icons.schedule_rounded,
            size: 15,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  height: 1.1,
                ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  static Widget accentOrb(Color onColor, {double size = 40}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: onColor.withOpacity(0.06),
      ),
    );
  }
}
