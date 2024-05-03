import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';


class CircleWidget extends StatelessWidget {
  final String text;
  final String svgImage;
  const CircleWidget({
    super.key,
    required this.text,
    required this.svgImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      height: 25,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SvgPicture.asset(svgImage),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
