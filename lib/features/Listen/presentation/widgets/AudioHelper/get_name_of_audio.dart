import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class GetNameOfAudio extends StatelessWidget {
  final AudioPlayer audioPlayer;
  const GetNameOfAudio({
    super.key,
    required this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SequenceState?>(
      stream: audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final state = snapshot.data!;
          if (state.sequence.isEmpty) {
            return FittedBox(
              child: Text(
                'No Name',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
          }
          final metadata = state.currentSource!.tag as MediaItem?;
          if (metadata != null) {
            return Text(
              metadata.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            );
          }
        }
        return const SizedBox();
      },
    );
  }
}
