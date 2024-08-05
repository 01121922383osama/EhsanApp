import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/extension/blurry_widget.dart';
import '../../../../core/widgets/animation_colors.dart';

import '../../../../config/routes/routes_name.dart';
import '../../../../core/extension/extension.dart';
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
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return false;
        },
        child: AnimationColorsContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: ListView(
              children: [
                BuildTextWidget(
                  text1: AppLocalizations.of(context)!.welcomeBack,
                  text2: AppLocalizations.of(context)!.contentLoginPage,
                ).blurry(),
                BuildTextFieldWidget(
                    hintText: AppLocalizations.of(context)!.emailHint),
                const SizedBox(height: 20),
                BuildTextFieldWidget(
                    hintText: AppLocalizations.of(context)!.passwordHint),
                const SizedBox(height: 15),
                const BuildRememerWidget(),
                SizedBox(height: context.width * 0.1 - 25),
                CustomIconButton(
                  textButton: AppLocalizations.of(context)!.signIn,
                  onPressed: () {
                    context.pushReplacementNamed(pageRoute: RoutesName.app);
                  },
                ),
                const SizedBox(height: 35),
                BuildOtherSignInWithWidget(
                  text1: AppLocalizations.of(context)!.donthaveAnAccount,
                  text2: AppLocalizations.of(context)!.signUp,
                  onTap: () =>
                      context.pushNamed(pageRoute: RoutesName.registerscreen),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
