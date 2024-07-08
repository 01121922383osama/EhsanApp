import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../Setting/presentation/cubit/Theme/theme_cubit.dart';

class TrailingWidget extends StatelessWidget {
  final String suraName;
  const TrailingWidget({super.key, required this.suraName});

  @override
  Widget build(BuildContext context) {
    return Text(
      suraName,
      style: TextStyle(
        color: context.read<ThemeCubit>().state
            ? AppColors.white
            : AppColors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
