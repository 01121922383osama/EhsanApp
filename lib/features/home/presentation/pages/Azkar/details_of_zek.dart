import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/build_leading_widget.dart';
import '../../../../../core/widgets/custom_appbar.dart';
import '../../../../Quran/presentation/widgets/build_avatar_surah.dart';
import 'models/array.dart';

class DetailsOfZekr extends StatelessWidget {
  final String title;
  final List<ArrayModel> zekr;
  const DetailsOfZekr({
    super.key,
    required this.zekr,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: Text(
          title,
          style: AppTextStyles.textStyleFont20,
        ),
        leading: const BuildIconBackWidget(),
      ),
      body: Stack(
        children: [
          Scrollbar(
            child: ListView.builder(
              itemCount: zekr.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  alignment: AlignmentDirectional.center,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                    border: Border.all(),
                  ),
                  child: Column(
                    children: [
                      BuildAvatarNumber(
                        index: index,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          zekr[index].text,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.textStyleFont20,
                        ),
                      ),
                      Chip(
                        label: Text(
                          '${AppLocalizations.of(context)!.howOfen} : ${zekr[index].count}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
