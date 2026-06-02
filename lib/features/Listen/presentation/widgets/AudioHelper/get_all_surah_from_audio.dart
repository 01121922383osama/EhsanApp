import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../home/presentation/widgets/home_feature_ui.dart';
import '../../../../home/presentation/widgets/home_prayer_ui.dart';

class GetAllSurahWidget extends StatelessWidget {
  const GetAllSurahWidget({
    super.key,
    required this.audioPlayer,
    this.onSurahTap,
  });

  final AudioPlayer audioPlayer;
  final Future<void> Function(int index)? onSurahTap;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SequenceState?>(
      stream: audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        final sequence = state?.sequence ?? [];
        final currentIndex = state?.currentIndex ?? -1;

        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: HomeFeatureUi.pagePadding.copyWith(top: 8, bottom: 8),
          itemCount: sequence.length,
          separatorBuilder: (_, __) =>
              const SizedBox(height: HomePrayerUi.itemGap),
          itemBuilder: (context, index) {
            final isCurrent = index == currentIndex;
            final title = sequence[index].tag.title as String? ?? '';

            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  if (onSurahTap != null) {
                    await onSurahTap!(index);
                  } else {
                    await audioPlayer.seek(Duration.zero, index: index);
                    await audioPlayer.play();
                  }
                },
                borderRadius: BorderRadius.circular(HomePrayerUi.radius),
                child: Ink(
                  height: 48,
                  padding: const EdgeInsets.symmetric(
                    horizontal: HomePrayerUi.horizontalInset,
                  ),
                  decoration: HomeFeatureUi.neutralCardDecoration(
                    context,
                    selected: isCurrent,
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      HomeFeatureUi.indexBadge(context, index),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          title,
                          textDirection: TextDirection.rtl,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: isCurrent
                                        ? FontWeight.w800
                                        : FontWeight.w600,
                                    fontSize: 14,
                                  ),
                        ),
                      ),
                      if (isCurrent)
                        Icon(
                          Icons.graphic_eq_rounded,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
