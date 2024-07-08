import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';
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
                  BuildTextWidget(
                    text1: AppLocalizations.of(context)!.createAccount,
                    text2: AppLocalizations.of(context)!.contentRegisterPage,
                  ),
                  BuildTextFieldWidget(
                      hintText: AppLocalizations.of(context)!.emailHint),
                  const SizedBox(height: 20),
                  BuildTextFieldWidget(
                      hintText: AppLocalizations.of(context)!.passwordHint),
                  const SizedBox(height: 20),
                  BuildTextFieldWidget(
                    hintText: AppLocalizations.of(context)!.confirmNewPassword,
                  ),
                  SizedBox(height: context.width * 0.1 - 25),
                  CustomIconButton(
                    textButton: AppLocalizations.of(context)!.createAccount,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 35),
                  BuildOtherSignInWithWidget(
                    text1: AppLocalizations.of(context)!.allreadyHaveAccount,
                    text2: AppLocalizations.of(context)!.signIn,
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
