import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../config/routes/routes_name.dart';
import '../../../../core/extension/extension.dart';
import 'build_list_widgtet.dart';

class BuildListBooks extends StatelessWidget {
  const BuildListBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BuildListTileWidget(
            titlel: AppLocalizations.of(context)!.holyQuran,
            trailing: const Icon(
              CupertinoIcons.book,
            ),
            onTap: () {
              context.pushNamed(pageRoute: RoutesName.quranPage);
            },
          ),
          BuildListTileWidget(
            titlel: AppLocalizations.of(context)!.tfsir,
            trailing: const Icon(
              Icons.menu_book,
            ),
          ),
        ],
      ),
    );
  }
}
