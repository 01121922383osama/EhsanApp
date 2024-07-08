import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../Setting/presentation/cubit/Theme/theme_cubit.dart';
import '../../data/models/quran_list_model.dart';
import '../pages/surah_page.dart';
import 'leading_widget.dart';
import 'subtitle_widget.dart';

class BuildSoraNamesWidget extends StatelessWidget {
  final List<QuranList> quranList;
  const BuildSoraNamesWidget({super.key, required this.quranList});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: quranList.length,
      itemBuilder: (context, index) {
        final quran = quranList[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: LeadingWidget(index: index),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: context.read<ThemeCubit>().state
                    ? AppColors.white.withOpacity(0.5)
                    : AppColors.white,
              ),
            ),
            title: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: quran.surahEnglish,
                    style: TextStyle(
                      color: context.read<ThemeCubit>().state
                          ? AppColors.white
                          : AppColors.black,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: ' (${quran.describeSurah})',
                    style: TextStyle(
                      color: context.read<ThemeCubit>().state
                          ? AppColors.white
                          : AppColors.redDart,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            subtitle: SubTitelWidget(
              surahName: quran.surahArabic!,
              manyAyah: quran.manyAyah!,
              revelationType: quran.describeSurah!,
            ),
            onTap: () {
              context.push(
                widget: SurahPage(
                  suraName: quran.surahArabic,
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
