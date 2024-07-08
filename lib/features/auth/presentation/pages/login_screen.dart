import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../config/routes/routes_name.dart';
import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_icon_widget.dart';
import '../../../app/presentation/pages/app_page.dart';
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                BuildTextWidget(
                  text1: AppLocalizations.of(context)!.welcomeBack,
                  text2: AppLocalizations.of(context)!.contentLoginPage,
                ),
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
                    context.pushAndRemoveUntil(widget: AppPage());
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
