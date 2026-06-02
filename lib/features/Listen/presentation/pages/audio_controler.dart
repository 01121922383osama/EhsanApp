import 'package:flutter/material.dart';
import 'package:free_lancer/l10n/app_localizations.dart';
import 'package:just_audio/just_audio.dart';

import '../../../home/presentation/widgets/home_prayer_ui.dart';
import '../widgets/listen_ui.dart';

void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(HomePrayerUi.radius),
      ),
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => SizedBox(
          height: 96,
          child: Column(
            children: [
              Text(
                '${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
              ),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? 1.0,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListenUi.controlIconButton(
          context: context,
          icon: Icons.volume_up_rounded,
          onPressed: () {
            showSliderDialog(
              context: context,
              title: AppLocalizations.of(context)!.volume,
              divisions: 10,
              min: 0.0,
              max: 1.0,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) {
            return ListenUi.controlIconButton(
              context: context,
              icon: Icons.skip_previous_rounded,
              onPressed: player.hasPrevious ? player.seekToPrevious : null,
            );
          },
        ),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;

            Widget centerChild;
            VoidCallback? onPressed;

            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              centerChild = SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: scheme.onPrimary,
                ),
              );
              onPressed = null;
            } else if (playing != true) {
              centerChild = Icon(
                Icons.play_arrow_rounded,
                size: 30,
                color: scheme.onPrimary,
              );
              onPressed = player.play;
            } else if (processingState != ProcessingState.completed) {
              centerChild = Icon(
                Icons.pause_rounded,
                size: 30,
                color: scheme.onPrimary,
              );
              onPressed = player.pause;
            } else {
              centerChild = Icon(
                Icons.replay_rounded,
                size: 28,
                color: scheme.onPrimary,
              );
              onPressed = () => player.seek(
                    Duration.zero,
                    index: player.effectiveIndices.first,
                  );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Material(
                color: scheme.primary,
                shape: const CircleBorder(),
                elevation: 2,
                shadowColor: scheme.primary.withOpacity(0.35),
                child: InkWell(
                  onTap: onPressed,
                  customBorder: const CircleBorder(),
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Center(child: centerChild),
                  ),
                ),
              ),
            );
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) {
            return ListenUi.controlIconButton(
              context: context,
              icon: Icons.skip_next_rounded,
              onPressed: player.hasNext ? player.seekToNext : null,
            );
          },
        ),
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) {
            return ListenUi.controlIconButton(
              context: context,
              icon: Icons.speed_rounded,
              label: '${snapshot.data?.toStringAsFixed(1) ?? '1.0'}x',
              onPressed: () {
                showSliderDialog(
                  context: context,
                  title: AppLocalizations.of(context)!.speed,
                  divisions: 10,
                  min: 0.5,
                  max: 1.5,
                  stream: player.speedStream,
                  onChanged: player.setSpeed,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
