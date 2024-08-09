import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;

import '../../../Setting/presentation/cubit/ChangeFonts/change_fonts.dart';
import 'build_avatar_surah.dart';

class DetailsSurahWidget extends StatelessWidget {
  final int? indexOfSurah;
  const DetailsSurahWidget({
    super.key,
    this.indexOfSurah,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 0.2,
        );
      },
      itemCount: quran.getVerseCount(indexOfSurah! + 1),
      itemBuilder: (context, index) {
        return NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text.rich(
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              TextSpan(
                text: quran.getVerse(indexOfSurah! + 1, index + 1),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.read<ChangeFonts>().state,
                ),
                children: [
                  WidgetSpan(
                    child: BuildAvatarNumber(index: index),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
