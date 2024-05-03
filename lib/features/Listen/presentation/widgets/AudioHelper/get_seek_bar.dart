import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'position_data.dart';
import 'seek_bar.dart';

class GetSeekBarWidget extends StatelessWidget {
  final AudioPlayer audioPlayer;
  final Stream<PositionData>  positionDataStream;
  const GetSeekBarWidget({super.key, required this.audioPlayer, required this.positionDataStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PositionData>(
      stream: positionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        return SeekBar(
          duration: positionData?.duration ?? Duration.zero,
          position: positionData?.position ?? Duration.zero,
          bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
          onChangeEnd: (newPosition) {
            audioPlayer.seek(newPosition);
          },
        );
      },
    );
  }
}
