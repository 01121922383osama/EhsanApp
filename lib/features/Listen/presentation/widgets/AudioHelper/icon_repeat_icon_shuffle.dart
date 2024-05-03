import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../../core/utils/app_colors.dart';
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
              Icon(Icons.repeat, color: AppColors.black.withOpacity(0.5)),
              const Icon(Icons.repeat, color: AppColors.redDart),
              const Icon(Icons.repeat_one, color: AppColors.redDart),
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
                  ? const Icon(Icons.shuffle, color: AppColors.redDart)
                  : Icon(
                      Icons.shuffle,
                      color: AppColors.black.withOpacity(0.5),
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
