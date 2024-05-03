import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_svg.dart';
import '../../../../core/widgets/custom_icon_widget.dart';
import '../widgets/build_text_widget.dart';
import '../widgets/build_textfield_widget.dart';

class ForGetPasswordPage extends StatelessWidget {
  const ForGetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScaffold,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowIndicator();
              return false;
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const BuildTextWidget(
                    text1: AppString.forgotPassword,
                    text2: AppString.contentPassword,
                  ),
                  const BuildTextFieldWidget(
                    hintText: AppString.emailOrPhoneNumber,
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SvgPicture.asset(
                      AssetsSvg.key,
                      colorFilter: const ColorFilter.mode(
                        AppColors.red,
                        BlendMode.modulate,
                      ),
                      height: context.width * 0.3,
                    ),
                  ),
                  SvgPicture.asset(
                    AssetsSvg.forgotPasswordImage,
                    colorFilter: const ColorFilter.mode(
                      AppColors.red,
                      BlendMode.modulate,
                    ),
                    height: context.width * 0.6,
                  ),
                  CustomIconButton(
                    textButton: AppString.forgotPassword,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
