import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/routes/routes_name.dart';
import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';
import 'build_list_widgtet.dart';

class BuildListBooks extends StatelessWidget {
  const BuildListBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          BuildListTileWidget(
            titlel: 'Al-Quran',
            trailing: Icon(
              CupertinoIcons.book,
              color: AppColors.redDart,
              size: context.width / 6,
            ),
            onTap: () {
              context.pushNamed(pageRoute: RoutesName.quranPage);
            },
          ),
          BuildListTileWidget(
            titlel: 'Al-Tafsir',
            trailing: Icon(
              Icons.menu_book,
              color: AppColors.redDart,
              size: context.width / 6,
            ),
          ),
          BuildListTileWidget(
            titlel: 'Aqoidul Iman',
            trailing: Icon(
              Icons.menu_book_sharp,
              color: AppColors.redDart,
              size: context.width / 6,
            ),
          ),
        ],
      ),
    );
  }
}
