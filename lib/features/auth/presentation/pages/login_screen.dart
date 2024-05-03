import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../app/presentation/pages/app_page.dart';

import '../../../../config/routes/routes_name.dart';
import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_icon_widget.dart';
import '../widgets/build_other_auth_widget.dart';
import '../widgets/build_remember_widget.dart';
import '../widgets/build_text_widget.dart';
import '../widgets/build_textfield_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                    text1: AppString.welcomeBack,
                    text2: AppString.contentLoginPage,
                  ),
                  const BuildTextFieldWidget(hintText: AppString.emailHint),
                  const SizedBox(height: 20),
                  const BuildTextFieldWidget(hintText: AppString.passwordHint),
                  const SizedBox(height: 15),
                  const BuildRememerWidget(),
                  SizedBox(height: context.width * 0.1 - 25),
                  CustomIconButton(
                    textButton: AppString.signIn,
                    onPressed: () {
                      context.pushAndRemoveUntil(widget: const AppPage());
                    },
                  ),
                  const SizedBox(height: 35),
                  BuildOtherSignInWithWidget(
                    text1: AppString.donthaveAnAccount,
                    text2: AppString.signUp,
                    onTap: () =>
                        context.pushNamed(pageRoute: RoutesName.registerscreen),
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
