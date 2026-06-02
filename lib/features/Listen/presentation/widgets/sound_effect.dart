import 'package:flutter/material.dart';

class MusicVisualizer extends StatelessWidget {
  const MusicVisualizer({
    super.key,
    required this.colors,
    required this.duration,
    this.barCount,
    this.curve = Curves.easeInQuad,
  });

  final List<Color>? colors;
  final List<int>? duration;
  final int? barCount;
  final Curve? curve;

  @override
  Widget build(BuildContext context) {
    final palette = colors ?? const [Colors.grey];
    final timings = duration ?? const [1000];

    return LayoutBuilder(
      builder: (context, constraints) {
        const barWidth = 3.0;
        const gap = 2.0;
        final maxBars = ((constraints.maxWidth + gap) / (barWidth + gap))
            .floor()
            .clamp(12, 80);
        final count = barCount != null && barCount! < maxBars ? barCount! : maxBars;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List<Widget>.generate(
            count,
            (index) => Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  end: index == count - 1 ? 0 : gap,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: VisualComponent(
                    curve: curve ?? Curves.easeInQuad,
                    duration: timings[index % timings.length],
                    color: palette[index % palette.length],
                    barWidth: barWidth,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class VisualComponent extends StatefulWidget {
  const VisualComponent({
    super.key,
    required this.duration,
    required this.color,
    required this.curve,
    required this.barWidth,
  });

  final int duration;
  final Color color;
  final Curve curve;
  final double barWidth;

  @override
  State<VisualComponent> createState() => _VisualComponentState();
}

class _VisualComponentState extends State<VisualComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    );
    _animation = Tween<double>(begin: 4, end: 44).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.barWidth,
          height: _animation.value,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      },
    );
  }
}
