import 'package:flutter/material.dart';

class SpaceWidget extends StatelessWidget {
  final double height;
  final double width;
  final bool isSliver;

  const SpaceWidget({
    super.key,
    this.height = 15,
    this.width = 0,
    this.isSliver = true,
  });

  @override
  Widget build(BuildContext context) {
    final sizedBox = SizedBox(
      height: height,
      width: width,
    );

    return isSliver ? SliverToBoxAdapter(child: sizedBox) : sizedBox;
  }
}
