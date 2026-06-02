import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class GetNameOfAudio extends StatelessWidget {
  const GetNameOfAudio({
    super.key,
    required this.audioPlayer,
    this.compact = false,
  });

  final AudioPlayer audioPlayer;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SequenceState?>(
      stream: audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final state = snapshot.data!;
        if (state.sequence.isEmpty) {
          return Text(
            '—',
            textAlign: TextAlign.center,
            style: _titleStyle(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        }

        final metadata = state.currentSource?.tag as MediaItem?;
        if (metadata == null) return const SizedBox.shrink();

        return Text(
          metadata.title,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: _titleStyle(context),
          maxLines: compact ? 1 : 2,
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }

  TextStyle? _titleStyle(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return compact
        ? theme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 14,
          )
        : theme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          );
  }
}
