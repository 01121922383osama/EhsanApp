import 'package:flutter/material.dart';

import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';

class BuildListTileWidget extends StatelessWidget {
  final String titlel;
  final Widget trailing;
  final void Function()? onTap;
  const BuildListTileWidget({
    super.key,
    required this.titlel,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.lightgray,
          borderRadius: BorderRadius.circular(8),
        ),
        height: context.width / 4.5,
        alignment: Alignment.center,
        child: ListTile(
          title: Text(titlel),
          titleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.redDart,
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}
