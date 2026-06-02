import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/assets_svg.dart';

class BuildAvatarNumber extends StatelessWidget {
  final int index;
  const BuildAvatarNumber({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          SvgPicture.asset(
            AssetsSvg.verse,
            height: 35,
            width: 35,
            fit: BoxFit.contain,
          ),
          Text(
            '${index + 1}',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
