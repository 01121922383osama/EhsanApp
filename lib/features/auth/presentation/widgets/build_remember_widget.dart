import 'package:flutter/material.dart';

import '../../../../config/routes/routes_name.dart';
import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';

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
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                activeColor: AppColors.red,
                value: isClick,
                onChanged: (value) {
                  setState(() {
                    isClick = value!;
                  });
                },
              ),
              const Text(
                AppString.rememberMe,
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              context.pushNamed(pageRoute: RoutesName.forgetpasswordscreen);
            },
            child: const Text(
              AppString.forgotPassword,
              style: TextStyle(
                color: AppColors.red,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
