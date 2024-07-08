import 'package:flutter/cupertino.dart';

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
        childAspectRatio: 0.7,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/testing.png'),
              fit: BoxFit.cover,
            ),
            border: Border.all(color: AppColors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: AlignmentDirectional.center,
        );
      },
    );
  }
}
