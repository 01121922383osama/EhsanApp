import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/assets_svg.dart';

class BuildOtherBooks extends StatelessWidget {
  const BuildOtherBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: SvgPicture.asset(
            svgImage[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

List<String> svgImage = [
  AssetsSvg.ihsanBook,
  AssetsSvg.sera,
  AssetsSvg.sera,
  AssetsSvg.ihsanBook,
];
