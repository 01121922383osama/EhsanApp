import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:free_lancer/core/utils/app_colors.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/animation_colors.dart';
import '../../../../../core/widgets/build_leading_widget.dart';
import '../../widgets/body_azkar_page.dart';
import 'search_zekr.dart';

class AzkarPage extends StatelessWidget {
  const AzkarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: AnimationColorsContainer(
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BuildIconBackWidget(),
                Text(
                  AppLocalizations.of(context)!.azkar,
                  style: AppTextStyles.textStyleFont20,
                ),
                BuildIconBackWidget(
                  icon: const Icon(Icons.search, color: AppColors.black),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: ZekrSearchDelegate(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: const AnimationColorsContainer(
        child: BodyAzkarPage(),
      ),
    );
  }
}
