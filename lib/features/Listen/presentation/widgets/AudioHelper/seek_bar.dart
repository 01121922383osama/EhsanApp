import 'dart:math';

import 'package:flutter/material.dart';

class SeekBar extends StatefulWidget {
  const SeekBar({
    super.key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  });

  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  @override
  SeekBarState createState() => SeekBarState();
}

class SeekBarState extends State<SeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sliderThemeData = SliderTheme.of(context).copyWith(trackHeight: 3);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final maxMs = max(widget.duration.inMilliseconds.toDouble(), 1.0);

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 2),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          SliderTheme(
            data: _sliderThemeData.copyWith(
              thumbShape: HiddenThumbComponentShape(),
              activeTrackColor: scheme.primary.withOpacity(0.18),
              inactiveTrackColor: scheme.outline.withOpacity(0.14),
            ),
            child: ExcludeSemantics(
              child: Slider(
                min: 0.0,
                max: maxMs,
                value: min(
                  widget.bufferedPosition.inMilliseconds.toDouble(),
                  maxMs,
                ),
                onChanged: _onChanged,
                onChangeEnd: _onChangeEnd,
              ),
            ),
          ),
          SliderTheme(
            data: _sliderThemeData.copyWith(
              inactiveTrackColor: Colors.transparent,
              activeTrackColor: scheme.primary,
              thumbColor: scheme.primary,
            ),
            child: Slider(
              min: 0.0,
              max: maxMs,
              value: min(
                _dragValue ?? widget.position.inMilliseconds.toDouble(),
                maxMs,
              ),
              onChanged: _onChanged,
              onChangeEnd: _onChangeEnd,
            ),
          ),
          Positioned(
            right: 0,
            child: Text(
              _formatRemaining(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: scheme.onSurface.withOpacity(0.55),
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
            ),
          ),
        ],
      ),
    );
  }

  void _onChanged(double value) {
    setState(() => _dragValue = value);
    widget.onChanged?.call(Duration(milliseconds: value.round()));
  }

  void _onChangeEnd(double value) {
    widget.onChangeEnd?.call(Duration(milliseconds: value.round()));
    setState(() => _dragValue = null);
  }

  String _formatRemaining() {
    final remaining = widget.duration - widget.position;
    final text = remaining.toString().split('.').first;
    return RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})')
            .firstMatch(text)
            ?.group(1) ??
        text;
  }
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {}
}
