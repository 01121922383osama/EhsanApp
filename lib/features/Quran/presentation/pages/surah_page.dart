import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_svg.dart';
import '../../../../core/widgets/space_widget.dart';
import '../../../../core/widgets/build_leading_widget.dart';
import '../widgets/details_surah.dart';

final TextEditingController textEditingController = TextEditingController();
final ScrollController scrollController = ScrollController();

class SurahPage extends StatelessWidget {
  final String? suraName;
  final int? indexOfSurah;
  const SurahPage({super.key, this.suraName, this.indexOfSurah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              floating: true,
              leading: const Padding(
                padding: EdgeInsets.all(4),
                child: BuildIconBackWidget(),
              ),
              title: Text(suraName!),
              centerTitle: true,
              backgroundColor: AppColors.white,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(8),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size(double.infinity, 60),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await showSearchAyah(context);
                        },
                        child: Container(
                          width: context.width * 0.5,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.lightgray,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'أبحث عن الأيه',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: context.width * 0.3,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.lightgray,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AssetsSvg.tafsir,
                              width: 25,
                              height: 25,
                              alignment: Alignment.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SpaceWidget(height: 15),
            SliverToBoxAdapter(
              child: indexOfSurah != 0 && indexOfSurah != 8
                  ? const Center(
                      child: Text(
                        quran.basmala,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            DetailsSurahWidget(
              indexOfSurah: indexOfSurah,
              controller: scrollController,
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showSearchAyah(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: AlertDialog(
              title: const Text('أبحث عن الأيه'),
              content: ListView.builder(
                itemCount: quran.getVerseCount(indexOfSurah! + 1),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Text(
                      'الأيه رقم:',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    title: Text(
                      '${index + 1}',
                      textAlign: TextAlign.right,
                    ),
                    onTap: () async {
                      context.pop();
                      await scrollController.animateTo(
                        index * 160,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.linear,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
