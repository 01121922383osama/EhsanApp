import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/functions/prayer_schedule_helper.dart';
import '../../../../core/utils/app_durations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import 'home_prayer_ui.dart';

class CurrentPrayerCard extends StatefulWidget {
  const CurrentPrayerCard({
    super.key,
    required this.schedule,
    required this.nextPrayerLabel,
    required this.remainingLabel,
    required this.currentPrayerLabelBuilder,
  });

  final PrayerScheduleInfo schedule;
  final String nextPrayerLabel;
  final String remainingLabel;
  final String Function(String prayerName) currentPrayerLabelBuilder;

  @override
  State<CurrentPrayerCard> createState() => _CurrentPrayerCardState();
}

class _CurrentPrayerCardState extends State<CurrentPrayerCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _floatAnimation = Tween<double>(begin: 0, end: -3).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nextSlot = widget.schedule.slots[widget.schedule.nextIndex];
    final currentSlot = widget.schedule.slots[widget.schedule.currentIndex];
    final allPassed = widget.schedule.isPassedByIndex.every((p) => p);
    final prayerColor = AppColors.paryersTime[widget.schedule.nextIndex];
    final onColor = HomePrayerUi.readableOn(prayerColor);
    final mutedOnColor = onColor.withOpacity(0.72);

    return Container(
      width: double.infinity,
      height: HomePrayerUi.heroHeight,
      margin: const EdgeInsetsDirectional.only(bottom: HomePrayerUi.itemGap),
      decoration: HomePrayerUi.prayerCardDecoration(
        prayerColor: prayerColor,
        highlighted: true,
        withShadow: true,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          PositionedDirectional(
            top: -12,
            end: -12,
            child: HomePrayerUi.accentOrb(onColor, size: 44),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: HomePrayerUi.horizontalInset,
              vertical: 6,
            ),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.nextPrayerLabel,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: mutedOnColor,
                          height: 1,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        nextSlot.name,
                        style: AppTextStyles.textStyleFont20.copyWith(
                          color: onColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                        textDirection: TextDirection.rtl,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (!allPassed)
                        Text(
                          widget.currentPrayerLabelBuilder(currentSlot.name),
                          style: TextStyle(
                            fontSize: 9,
                            color: mutedOnColor,
                            height: 1,
                          ),
                          textDirection: TextDirection.rtl,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                AnimatedBuilder(
                  animation: _floatAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _floatAnimation.value),
                      child: child,
                    );
                  },
                  child: Image.asset(
                    nextSlot.imageAsset,
                    height: HomePrayerUi.heroIconSize,
                    width: HomePrayerUi.heroIconSize,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: onColor.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: onColor.withOpacity(0.2)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.remainingLabel,
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                          color: mutedOnColor,
                          height: 1,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        formatRemainingDuration(widget.schedule.remainingToNext),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: onColor,
                          height: 1,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: AppDurations.animation)
        .slideY(begin: 0.05, end: 0, duration: AppDurations.animation, curve: Curves.easeOutCubic);
  }
}
