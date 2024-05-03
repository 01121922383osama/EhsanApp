import 'package:flutter/material.dart';

import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_icon_widget.dart';
import '../widgets/build_other_auth_widget.dart';
import '../widgets/build_text_widget.dart';
import '../widgets/build_textfield_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScaffold,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return false;
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                children: [
                  const BuildTextWidget(
                    text1: AppString.createAccount,
                    text2: AppString.contentRegisterPage,
                  ),
                  const BuildTextFieldWidget(hintText: AppString.emailHint),
                  const SizedBox(height: 20),
                  const BuildTextFieldWidget(hintText: AppString.passwordHint),
                  const SizedBox(height: 20),
                  const BuildTextFieldWidget(
                    hintText: AppString.confirmNewPassword,
                  ),
                  SizedBox(height: context.width * 0.1 - 25),
                  CustomIconButton(
                    textButton: 'Sign Up',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 35),
                  BuildOtherSignInWithWidget(
                    text1: AppString.allreadyHaveAccount,
                    text2: AppString.signIn,
                    onTap: () => context.pop(),
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
