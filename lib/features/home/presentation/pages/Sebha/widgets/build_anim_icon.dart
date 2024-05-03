import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../SebehCubit/sabeh_cubit.dart';

class AnimIconWidget extends StatefulWidget {
  final double Function(int) getDouble;
  final IconData iconData;
  const AnimIconWidget(
      {super.key, required this.getDouble, required this.iconData});

  @override
  State<AnimIconWidget> createState() => _AnimIconWidgetState();
}

class _AnimIconWidgetState extends State<AnimIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOutCirc,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        animationController.forward().then((value) {
          animationController.reverse();
        });
        if (widget.iconData == Icons.add) {
          BlocProvider.of<SabehCubit>(context).increment();
        } else {
          BlocProvider.of<SabehCubit>(context).decrement();
        }
      },
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              for (int i = 0; i < 5; i++)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.red.withOpacity(
                          animationController.isCompleted
                              ? animation.value
                              : 0.5,
                        ),
                        spreadRadius: animation.value * 25,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: widget.getDouble(i),
                    backgroundColor: AppColors.transparent,
                  ),
                ),
              Icon(
                widget.iconData,
                size: 30,
                color: AppColors.white,
              ),
            ],
          );
        },
      ),
    );
  }
}
