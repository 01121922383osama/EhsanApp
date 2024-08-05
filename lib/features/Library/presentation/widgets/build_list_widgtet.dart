import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../Setting/presentation/cubit/Theme/theme_cubit.dart';

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
          color: context.read<ThemeCubit>().state
              ? AppColors.white.withOpacity(0.7)
              : AppColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
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
