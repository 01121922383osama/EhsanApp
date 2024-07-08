import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
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
        Row(
          children: [
            const Expanded(
              child: Divider(),
            ),
            Text(
              AppLocalizations.of(context)!.orSignInWith,
              style: AppTextStyles.textStyleFont13,
            ),
            const Expanded(
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
        Text(
          AppLocalizations.of(context)!.privacy,
          style: AppTextStyles.textStyleFont13,
        ),
        const SizedBox(height: 15),
        Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              TextSpan(
                text: text1,
                style: AppTextStyles.textStyleFont13,
              ),
              TextSpan(
                text: text2,
                style: AppTextStyles.textStyleFont13
                    .copyWith(color: AppColors.red),
                recognizer: TapGestureRecognizer()..onTap = onTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
