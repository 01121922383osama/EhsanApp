import 'package:flutter/material.dart';

import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import 'home_prayer_ui.dart';

class AnimPrayerTime extends StatefulWidget {
  const AnimPrayerTime({
    super.key,
    required this.image,
    required this.time,
    required this.prayerName,
    required this.index,
    this.isNext = false,
  });

  final String image;
  final String prayerName;
  final String time;
  final int index;
  final bool isNext;

  @override
  State<AnimPrayerTime> createState() => _AnimPrayerTimeState();
}

class _AnimPrayerTimeState extends State<AnimPrayerTime>
    with SingleTickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-0.2, 0.2),
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
    );
    if (widget.isNext) {
      _slideController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant AnimPrayerTime oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isNext && !_slideController.isAnimating) {
      _slideController.repeat(reverse: true);
    } else if (!widget.isNext && _slideController.isAnimating) {
      _slideController.stop();
      _slideController.value = 0;
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prayerColor = AppColors.paryersTime[widget.index];
    final onColor = HomePrayerUi.readableOn(prayerColor);
    final mutedOnColor = onColor.withOpacity(0.72);

    return Container(
      width: context.width,
      height: HomePrayerUi.listRowHeight,
      margin: const EdgeInsetsDirectional.only(bottom: HomePrayerUi.itemGap),
      decoration: HomePrayerUi.prayerCardDecoration(
        prayerColor: prayerColor,
        highlighted: widget.isNext,
        withShadow: widget.isNext,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PositionedDirectional(
            top: -10,
            end: -10,
            child: HomePrayerUi.accentOrb(onColor, size: 36),
          ),
          SlideTransition(
            position: _slideAnimation,
            child: Image.asset(
              widget.image,
              height: HomePrayerUi.listIconSize,
              width: HomePrayerUi.listIconSize,
            ),
          ),
          PositionedDirectional(
            start: HomePrayerUi.horizontalInset,
            child: Text(
              widget.prayerName,
              style: AppTextStyles.textStyleFont20.copyWith(
                color: onColor,
                fontSize: 15,
                fontWeight: widget.isNext ? FontWeight.w800 : FontWeight.w700,
                height: 1,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          PositionedDirectional(
            end: HomePrayerUi.horizontalInset,
            child: Text(
              widget.time,
              style: AppTextStyles.textStyleFont16.copyWith(
                color: mutedOnColor,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }
}
