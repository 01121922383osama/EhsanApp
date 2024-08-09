import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        }
        if (widget.iconData == Icons.remove) {
          BlocProvider.of<SabehCubit>(context).decrement();
        }
        if (widget.iconData == Icons.restart_alt) {
          BlocProvider.of<SabehCubit>(context).reset();
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
                        color: Colors.red.withOpacity(
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
                    backgroundColor: Colors.transparent,
                  ),
                ),
              Icon(
                widget.iconData,
                size: 30,
                color: Colors.white,
              ),
            ],
          );
        },
      ),
    );
  }
}
