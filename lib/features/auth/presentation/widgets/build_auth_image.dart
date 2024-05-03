import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BuildAuthImage extends StatelessWidget {
  final String image;
  const BuildAuthImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      child: SvgPicture.asset(image),
    );
  }
}
