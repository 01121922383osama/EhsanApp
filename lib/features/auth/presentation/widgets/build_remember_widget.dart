import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../config/routes/routes_name.dart';
import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class BuildRememerWidget extends StatefulWidget {
  const BuildRememerWidget({super.key});

  @override
  State<BuildRememerWidget> createState() => _BuildRememerWidgetState();
}

class _BuildRememerWidgetState extends State<BuildRememerWidget> {
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              context.pushNamed(pageRoute: RoutesName.forgetpasswordscreen);
            },
            child: Text(
              AppLocalizations.of(context)!.forgotPassword,
              style:
                  AppTextStyles.textStyleFont15.copyWith(color: AppColors.red),
            ),
          ),
          const Spacer(),
          Text(
            AppLocalizations.of(context)!.rememberMe,
            style: AppTextStyles.textStyleFont15,
          ),
          Checkbox(
            activeColor: AppColors.red,
            value: isClick,
            onChanged: (value) {
              setState(() {
                isClick = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
