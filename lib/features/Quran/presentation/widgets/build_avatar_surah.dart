import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_svg.dart';

class BuildAvatarNumber extends StatelessWidget {
  final int index;
  const BuildAvatarNumber({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FittedBox(
          alignment: AlignmentDirectional.center,
          clipBehavior: Clip.none,
          fit: BoxFit.scaleDown,
          child: Text(
            '${index + 1}',
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 15,
            ),
          ),
        ),
        SvgPicture.asset(
          AssetsSvg.verse,
          height: 35,
        ),
      ],
    );
  }
}
