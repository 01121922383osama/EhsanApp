import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../listen_ui.dart';
import 'get_name_of_audio.dart';

class IconRepeatIconShuffle extends StatelessWidget {
  const IconRepeatIconShuffle({super.key, required this.audioPlayer});

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<LoopMode>(
            stream: audioPlayer.loopModeStream,
            builder: (context, snapshot) {
              final loopMode = snapshot.data ?? LoopMode.off;
              const cycleModes = [
                LoopMode.off,
                LoopMode.all,
                LoopMode.one,
              ];
              final index = cycleModes.indexOf(loopMode);
              final icons = [
                Icons.repeat_rounded,
                Icons.repeat_rounded,
                Icons.repeat_one_rounded,
              ];
              return ListenUi.controlIconButton(
                context: context,
                icon: icons[index.clamp(0, icons.length - 1)],
                onPressed: () {
                  audioPlayer.setLoopMode(
                    cycleModes[(index + 1) % cycleModes.length],
                  );
                },
              );
            },
          ),
          Expanded(
            child: GetNameOfAudio(
              audioPlayer: audioPlayer,
              compact: true,
            ),
          ),
          StreamBuilder<bool>(
            stream: audioPlayer.shuffleModeEnabledStream,
            builder: (context, snapshot) {
              final enabled = snapshot.data ?? false;
              return ListenUi.controlIconButton(
                context: context,
                icon: Icons.shuffle_rounded,
                onPressed: () async {
                  final enable = !enabled;
                  if (enable) await audioPlayer.shuffle();
                  await audioPlayer.setShuffleModeEnabled(enable);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
