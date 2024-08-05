import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/build_leading_widget.dart';
import '../../../Setting/presentation/cubit/Theme/theme_cubit.dart';
import '../../data/models/quran_list_model.dart';
import '../pages/surah_page.dart';
import '../widgets/leading_widget.dart';
import '../widgets/subtitle_widget.dart';

class SearchQuran extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: IconButton(
          onPressed: () {
            if (query.isNotEmpty) {
              query = '';
            } else {
              close(context, false);
            }
          },
          icon: const Icon(Icons.close),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BuildIconBackWidget();
  }

  @override
  Widget buildResults(BuildContext context) {
    List<QuranList> results = quranList.where((quranItem) {
      return quranItem.surahArabic!
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          quranItem.surahEnglish!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: LeadingWidget(index: result.index!),
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
                    text: result.surahEnglish,
                    style: TextStyle(
                      color: context.read<ThemeCubit>().state
                          ? AppColors.white
                          : AppColors.black,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: ' (${result.manyAyah})',
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
              surahName: result.surahArabic!,
              manyAyah: result.manyAyah!,
              revelationType: result.describeSurah!,
            ),
            onTap: () {
              final indexSurah = quranList.indexWhere(
                  (quranItem) => quranItem.surahArabic == result.surahArabic);
              context.push(
                widget: SurahPage(
                  suraName: result.surahArabic,
                  indexOfSurah: indexSurah,
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<QuranList> suggestions = quranList.where((quranItem) {
      return quranItem.surahArabic!
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          quranItem.surahEnglish!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: LeadingWidget(index: suggestion.index!),
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
                    text: suggestion.surahEnglish,
                    style: TextStyle(
                      color: context.read<ThemeCubit>().state
                          ? AppColors.white
                          : AppColors.black,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: ' (${suggestion.describeSurah})',
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
              surahName: suggestion.surahArabic!,
              manyAyah: suggestion.manyAyah!,
              revelationType: suggestion.describeSurah!,
            ),
            onTap: () {
              final indexSurah = quranList.indexWhere((quranItem) =>
                  quranItem.surahArabic == suggestion.surahArabic);
              context.pushReplacement(
                widget: SurahPage(
                  suraName: suggestion.surahArabic,
                  indexOfSurah: indexSurah,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

List<QuranList> quranList = List.generate(
  quran.totalSurahCount,
  (index) {
    return QuranList(
      index: index + 1,
      surahArabic: quran.getSurahNameArabic(index + 1),
      surahEnglish: quran.getSurahName(index + 1),
      surahFr: quran.getSurahNameFrench(index + 1),
      ayat: quran.getSurahName(index + 1),
      manyAyah: quran.getVerseCount(index + 1),
      mdnyahORmkyah: quran.getPlaceOfRevelation(index + 1),
      describeSurah: quran.getSurahNameEnglish(index + 1),
      surahURL: quran.getAudioURLBySurah(index + 1),
    );
  },
);
