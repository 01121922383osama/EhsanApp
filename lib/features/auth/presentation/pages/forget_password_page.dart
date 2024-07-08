import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
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
                  BuildTextWidget(
                    text1: AppLocalizations.of(context)!.forgotPassword,
                    text2: AppLocalizations.of(context)!.contentPassword,
                  ),
                  BuildTextFieldWidget(
                    hintText: AppLocalizations.of(context)!.emailOrPhoneNumber,
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
                      height: 100,
                    ),
                  ),
                  SvgPicture.asset(
                    AssetsSvg.forgotPasswordImage,
                    colorFilter: const ColorFilter.mode(
                      AppColors.red,
                      BlendMode.modulate,
                    ),
                    height: 250,
                  ),
                  CustomIconButton(
                    textButton: AppLocalizations.of(context)!.forgotPassword,
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
