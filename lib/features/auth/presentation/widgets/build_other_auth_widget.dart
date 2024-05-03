import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_svg.dart';
import 'build_auth_image.dart';

class BuildOtherSignInWithWidget extends StatelessWidget {
  final String text1;
  final String text2;
  final Function() onTap;
  const BuildOtherSignInWithWidget({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(
              child: Divider(),
            ),
            Text(
              AppString.orSignInWith,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
            Expanded(
              child: Divider(),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BuildAuthImage(image: AssetsSvg.google),
            BuildAuthImage(image: AssetsSvg.faceBook),
            BuildAuthImage(image: AssetsSvg.apple),
          ],
        ),
        const SizedBox(height: 25),
        const Text(
          AppString.privacy,
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 13,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 15),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: text1,
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
              ),
              TextSpan(
                text: text2,
                style: const TextStyle(
                  color: AppColors.red,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
                recognizer: TapGestureRecognizer()..onTap = onTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
