import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../pages/surah_page.dart';
import 'leading_widget.dart';
import 'subtitle_widget.dart';

class BuildSoraNamesWidget extends StatelessWidget {
  const BuildSoraNamesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: quran.totalSurahCount,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: LeadingWidget(index: index),
            title: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: quran.getSurahName(index + 1),
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: ' (${quran.getSurahNameEnglish(index + 1)})',
                    style: const TextStyle(
                      color: AppColors.redDart,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            subtitle: SubTitelWidget(
              surahName: quran.getSurahNameArabic(index + 1),
              manyAyah: quran.getVerseCount(index + 1),
              revelationType: quran.getPlaceOfRevelation(index + 1),
            ),
            onTap: () {
              context.push(
                widget: SurahPage(
                  suraName: quran.getSurahNameArabic(index + 1),
                  indexOfSurah: index,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
