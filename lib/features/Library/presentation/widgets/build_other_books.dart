import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Setting/presentation/cubit/Theme/theme_cubit.dart';

import '../../../../core/extension/screen_utils.dart';
import '../../../../core/utils/app_colors.dart';

class BuildOtherBooks extends StatelessWidget {
  const BuildOtherBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.isMobile ? 2 : 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.9,
      ),
      itemCount: texts.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.lightgray.withOpacity(0.2),
            border: Border.all(
              color: context.read<ThemeCubit>().state
                  ? AppColors.white.withOpacity(0.3)
                  : AppColors.lightblue,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: AlignmentDirectional.center,
          child: Text(
            texts[index],
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        );
      },
    );
  }
}

List<String> texts = [
  'أحاديث',
  'أدعيه',
  'أذكار',
  'الحج والعمره',
  'السيره النبويه',
  'رمضان',
];
