import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'get_name_of_audio.dart';

class IconRepeatIconShuffle extends StatelessWidget {
  final AudioPlayer audioPlayer;
  const IconRepeatIconShuffle({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StreamBuilder<LoopMode>(
          stream: audioPlayer.loopModeStream,
          builder: (context, snapshot) {
            final loopMode = snapshot.data ?? LoopMode.off;
            final icons = [
              const Icon(Icons.repeat),
              const Icon(Icons.repeat_one),
            ];
            const cycleModes = [
              LoopMode.off,
              LoopMode.all,
              LoopMode.one,
            ];
            final index = cycleModes.indexOf(loopMode);
            return IconButton(
              icon: icons[index],
              onPressed: () {
                audioPlayer.setLoopMode(cycleModes[
                    (cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
              },
            );
          },
        ),
        GetNameOfAudio(audioPlayer: audioPlayer),
        StreamBuilder<bool>(
          stream: audioPlayer.shuffleModeEnabledStream,
          builder: (context, snapshot) {
            final shuffleModeEnabled = snapshot.data ?? false;
            return IconButton(
              icon: shuffleModeEnabled
                  ? const Icon(Icons.shuffle)
                  : const Icon(
                      Icons.shuffle,
                    ),
              onPressed: () async {
                final enable = !shuffleModeEnabled;
                if (enable) {
                  await audioPlayer.shuffle();
                }
                await audioPlayer.setShuffleModeEnabled(enable);
              },
            );
          },
        ),
      ],
    );
  }
}
