import 'package:flutter/material.dart';
import '../../../../core/extension/extension.dart';
import '%D8%A7%D8%AD%D8%A7%D8%AF%D9%8A%D8%AB/ahadeth_page.dart';
import '%D8%A7%D8%AF%D8%B9%D9%8A%D9%87/ad3ya_page.dart';
import '%D8%A7%D8%B0%D9%83%D8%A7%D8%B1/azkar_of_books_page.dart';
import '%D8%A7%D9%84%D8%AD%D8%AC%20%D9%88%D8%A7%D9%84%D8%B9%D9%85%D8%B1%D9%87/haj_and_3omra.dart';
import '%D8%A7%D9%84%D8%B3%D9%8A%D8%B1%D9%87%20%D8%A7%D9%84%D9%86%D8%A8%D9%88%D9%8A%D9%87/sera_nabwya.dart';
import '%D8%B1%D9%85%D8%B6%D8%A7%D9%86/rmdan_page.dart';

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
        return InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            context.push(widget: _pages(texts[index])[index]);
          },
          child: Container(
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
          ),
        );
      },
    );
  }
}

List<Widget> _pages(String title) => [
      AhadethPage(title: title),
      Ad3yaPage(title: title),
      AzkarOfBooksPage(title: title),
      HajAnd3omra(title: title),
      SeraNabwya(title: title),
      RmdanPage(title: title),
    ];

List<String> texts = [
  'أحاديث',
  'أدعيه',
  'أذكار',
  'الحج والعمره',
  'السيره النبويه',
  'رمضان',
];
