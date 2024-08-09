import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_lancer/features/Setting/presentation/cubit/Theme/theme_cubit.dart';

import '../../../../core/extension/extension.dart';
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
          color: context.read<ThemeCubit>().state
              ? Colors.transparent
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(),
          ),
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: LeadingWidget(index: index),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            title: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: quran.surahEnglish,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: ' (${quran.describeSurah})',
                    style: const TextStyle(
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
