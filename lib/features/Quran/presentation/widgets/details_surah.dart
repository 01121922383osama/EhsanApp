import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;

import '../../../Setting/presentation/cubit/ChangeFonts/change_fonts.dart';
import 'build_avatar_surah.dart';

/// Keeps verse lookups fast when chunks rebuild.
final _verseCache = <String, String>{};

const _bismillahPrefix = 'بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ';

bool _showsBismillahHeader(int? indexOfSurah) =>
    indexOfSurah != null && indexOfSurah != 0 && indexOfSurah != 8;

String _withoutLeadingBismillah(String verseText) {
  if (!verseText.startsWith(_bismillahPrefix)) return verseText;
  return verseText.substring(_bismillahPrefix.length).trimLeft();
}

String _cachedVerse(
  int surahNumber,
  int verseIndex, {
  required int? indexOfSurah,
}) {
  final key = '$surahNumber:$verseIndex';
  return _verseCache.putIfAbsent(key, () {
    var text = quran.getVerse(surahNumber, verseIndex);
    if (_showsBismillahHeader(indexOfSurah) && verseIndex == 1) {
      text = _withoutLeadingBismillah(text);
    }
    return text;
  });
}

class DetailsSurahWidget extends StatelessWidget {
  static const _chunkSize = 18;

  final int? indexOfSurah;
  const DetailsSurahWidget({
    super.key,
    this.indexOfSurah,
  });

  @override
  Widget build(BuildContext context) {
    final surahNumber = indexOfSurah! + 1;
    final verseCount = quran.getVerseCount(surahNumber);
    final chunkCount = (verseCount + _chunkSize - 1) ~/ _chunkSize;

    return BlocBuilder<ChangeFonts, double>(
      builder: (context, fontSize) {
        return SliverList.builder(
          itemCount: chunkCount,
          itemBuilder: (context, chunkIndex) {
            final startVerse = chunkIndex * _chunkSize + 1;
            final endVerse = (startVerse + _chunkSize - 1).clamp(1, verseCount);

            return Padding(
              padding: EdgeInsets.fromLTRB(
                10,
                chunkIndex == 0 ? 10 : 0,
                10,
                chunkIndex == chunkCount - 1 ? 10 : 0,
              ),
              child: Text.rich(
                textAlign: TextAlign.justify,
                textDirection: TextDirection.rtl,
                TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    height: 2,
                  ),
                  children: _chunkSpans(
                    surahNumber: surahNumber,
                    startVerse: startVerse,
                    endVerse: endVerse,
                    indexOfSurah: indexOfSurah,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<InlineSpan> _chunkSpans({
    required int surahNumber,
    required int startVerse,
    required int endVerse,
    required int? indexOfSurah,
  }) {
    final spans = <InlineSpan>[];

    for (var verseIndex = startVerse; verseIndex <= endVerse; verseIndex++) {
      final verseText = _cachedVerse(
        surahNumber,
        verseIndex,
        indexOfSurah: indexOfSurah,
      );
      final isLastInChunk = verseIndex == endVerse;

      spans.add(
        TextSpan(
          text: isLastInChunk ? verseText : '$verseText ',
        ),
      );
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: BuildAvatarNumber(index: verseIndex - 1),
          ),
        ),
      );
    }

    return spans;
  }
}
