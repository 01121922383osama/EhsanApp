import 'package:flutter/material.dart';

import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class AnimPrayerTime extends StatefulWidget {
  final String image;
  final String prayerName;
  final String time;
  final Widget widget;
  final int index;
  const AnimPrayerTime({
    super.key,
    required this.image,
    required this.time,
    required this.prayerName,
    required this.widget,
    required this.index,
  });

  @override
  State<AnimPrayerTime> createState() => _AnimPrayerTimeState();
}

class _AnimPrayerTimeState extends State<AnimPrayerTime>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> animation;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(-0.3, 0.3),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
      ),
    );
    animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: 70,
      margin: const EdgeInsetsDirectional.all(3),
      decoration: BoxDecoration(
        color: AppColors.paryersTime[widget.index].withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PositionedDirectional(
            end: 15,
            child: widget.widget,
          ),
          SlideTransition(
            position: animation,
            child: Image.asset(
              widget.image,
              height: 35,
              alignment: Alignment.center,
            ),
          ),
          PositionedDirectional(
            start: 15,
            child: Column(
              children: [
                Text(
                  widget.prayerName,
                  style: AppTextStyles.textStyleFont20,
                ),
                Text(
                  widget.time,
                  style: AppTextStyles.textStyleFont20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
