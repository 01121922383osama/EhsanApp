import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/paints_app.dart';
import '../cubit/app_cubit.dart';

class BuildIconNav extends StatefulWidget {
  final AppState state;
  final int index;
  final IconData iconOne;
  final IconData iconTwo;
  final String tooltip;
  final PageController pageController;
  const BuildIconNav({
    super.key,
    required this.state,
    required this.index,
    required this.iconOne,
    required this.iconTwo,
    required this.tooltip,
    required this.pageController,
  });

  @override
  State<BuildIconNav> createState() => _BuildIconNavState();
}

class _BuildIconNavState extends State<BuildIconNav>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeoutOpacityAnimation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    fadeoutOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
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
    return Tooltip(
      message: widget.tooltip,
      child: CustomPaint(
        painter: widget.state.index == widget.index ? PaintLine() : null,
        child: Container(
          decoration: BoxDecoration(
            color: widget.state.index == widget.index
                ? Colors.white.withOpacity(0.2)
                : Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(25),
          ),
          child: IconButton(
            onPressed: () {
              context.read<AppCubit>().changeIndex(widget.index);
              widget.pageController.jumpToPage(widget.index);
            },
            icon: AnimatedRotation(
              duration: const Duration(milliseconds: 500),
              turns: widget.state.index == widget.index ? 1.0 : 0.0,
              child: Icon(
                widget.state.index == widget.index
                    ? widget.iconOne
                    : widget.iconTwo,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
