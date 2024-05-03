import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../core/utils/app_colors.dart';
import 'build_avatar_surah.dart';

class DetailsSurahWidget extends StatelessWidget {
  final ScrollController? controller;
  final int? indexOfSurah;
  const DetailsSurahWidget({
    super.key,
    this.controller,
    this.indexOfSurah,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return const Divider(
                color: AppColors.primary,
                thickness: 0.2,
              );
            },
            controller: controller,
            itemCount: quran.getVerseCount(indexOfSurah! + 1),
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text.rich(
                  TextSpan(
                    text: quran.getVerse(indexOfSurah! + 1, index + 1),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    children: [
                      WidgetSpan(
                        child: BuildAvatarNumber(index: index),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
