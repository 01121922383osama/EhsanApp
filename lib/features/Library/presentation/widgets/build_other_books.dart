import 'package:flutter/cupertino.dart';

import '../../../../core/extension/screen_utils.dart';

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
            borderRadius: BorderRadius.circular(8),
            border: Border.all(),
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
