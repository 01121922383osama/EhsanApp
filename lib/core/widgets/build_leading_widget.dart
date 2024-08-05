import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/Setting/presentation/cubit/Theme/theme_cubit.dart';
import '../extension/extension.dart';
import '../utils/app_colors.dart';

class BuildIconBackWidget extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? icon;
  const BuildIconBackWidget({
    super.key,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: CircleAvatar(
        backgroundColor: context.read<ThemeCubit>().state
            ? AppColors.white.withOpacity(0.5)
            : AppColors.lightblue,
        radius: 25,
        child: IconButton(
          onPressed: onPressed ??
              () {
                context.pop();
              },
          icon: icon ??
              const Icon(
                CupertinoIcons.back,
                color: AppColors.black,
              ),
        ),
      ),
    );
  }
}
