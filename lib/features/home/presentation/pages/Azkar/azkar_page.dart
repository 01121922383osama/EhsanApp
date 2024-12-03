import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../core/widgets/custom_appbar.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/build_leading_widget.dart';
import 'body_azkar_page.dart';
import 'search_zekr.dart';

class AzkarPage extends StatelessWidget {
  const AzkarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        leading: const BuildIconBackWidget(),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.azkar,
          style: AppTextStyles.textStyleFont20,
        ),
        actions: [
          BuildIconBackWidget(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ZekrSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: const BodyAzkarPage(),
    );
  }
}
