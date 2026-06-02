import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../core/extension/extension.dart';
import '../../../../injection_container.dart';
import '../../data/services/quran_audio_service.dart';
import '../pages/build_audio_page.dart';
import 'AudioHelper/get_name_of_audio.dart';

class QuranMiniPlayer extends StatelessWidget {
  const QuranMiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final service = sl<QuranAudioService>();
    final player = service.player;

    return StreamBuilder<PlayerState>(
      stream: player.playerStateStream,
      builder: (context, snapshot) {
        if (!service.hasActiveSession) return const SizedBox.shrink();

        final state = snapshot.data;
        final processingState = state?.processingState;
        if (processingState == ProcessingState.idle) {
          return const SizedBox.shrink();
        }

        final playing = state?.playing ?? false;
        final isLoading = processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering;
        if (!playing && !isLoading) {
          return const SizedBox.shrink();
        }

        final scheme = Theme.of(context).colorScheme;

        return Material(
          color: scheme.surface,
          elevation: 6,
          child: InkWell(
            onTap: () {
              final urls = service.currentUrls;
              if (urls == null) return;
              context.push(widget: BuildAudioPage(audioUrl: urls));
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: scheme.outline.withOpacity(0.12)),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.menu_book_rounded, color: scheme.primary, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GetNameOfAudio(
                      audioPlayer: player,
                      compact: true,
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      if (playing) {
                        player.pause();
                      } else {
                        player.play();
                      }
                    },
                    icon: Icon(
                      playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    ),
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
