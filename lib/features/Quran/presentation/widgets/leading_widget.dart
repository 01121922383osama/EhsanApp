import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_svg.dart';

class LeadingWidget extends StatelessWidget {
  final int index;
  const LeadingWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          AssetsSvg.verse,
        ),
        Text(
          '${index + 1}',
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
