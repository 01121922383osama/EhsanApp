import 'package:flutter/cupertino.dart';

class SpaceWidget extends StatelessWidget {
  final double height;
  final double width;
  const SpaceWidget({
    super.key,
    this.height = 15,
    this.width = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
        width: width,
      ),
    );
  }
}
