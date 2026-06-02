import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../../../../core/utils/app_durations.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/build_leading_widget.dart';
import '../../../../../core/widgets/custom_appbar.dart';
import '../../widgets/home_feature_ui.dart';
import '../../widgets/home_prayer_ui.dart';
import 'models/array.dart';

enum _ZekrStatus { notStarted, inProgress, completed }

class DetailsOfZekr extends StatefulWidget {
  const DetailsOfZekr({
    super.key,
    required this.zekr,
    required this.title,
  });

  final String title;
  final List<ArrayModel> zekr;

  @override
  State<DetailsOfZekr> createState() => _DetailsOfZekrState();
}

class _DetailsOfZekrState extends State<DetailsOfZekr> {
  late final PageController _pageController;
  late final ScrollController _chipScrollController;
  late final List<int> _progress;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _progress = List.filled(widget.zekr.length, 0);
    _pageController = PageController();
    _chipScrollController = ScrollController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _chipScrollController.dispose();
    super.dispose();
  }

  int _targetCount(int index) {
    final count = widget.zekr[index].count;
    return count <= 0 ? 1 : count;
  }

  _ZekrStatus _statusFor(int index) {
    final target = _targetCount(index);
    final current = _progress[index];
    if (current >= target) return _ZekrStatus.completed;
    if (current > 0) return _ZekrStatus.inProgress;
    return _ZekrStatus.notStarted;
  }

  int _completedItemsCount() {
    var done = 0;
    for (var i = 0; i < widget.zekr.length; i++) {
      if (_statusFor(i) == _ZekrStatus.completed) done++;
    }
    return done;
  }

  void _onIndexChanged(int index) {
    if (_currentIndex == index) {
      _scrollChipIntoView(index);
      return;
    }
    setState(() => _currentIndex = index);
    _scrollChipIntoView(index);
  }

  void _scrollChipIntoView(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_chipScrollController.hasClients) return;
      const chipExtent = 42.0;
      final target = (index * chipExtent).clamp(
        0.0,
        _chipScrollController.position.maxScrollExtent,
      );
      _chipScrollController.animateTo(
        target,
        duration: AppDurations.pageScroll,
        curve: Curves.easeOutCubic,
      );
    });
  }

  Future<void> _goToIndex(int index) async {
    if (index < 0 || index >= widget.zekr.length) return;
    if (index == _currentIndex) return;
    if (!_pageController.hasClients) {
      _onIndexChanged(index);
      return;
    }

    await _pageController.animateToPage(
      index,
      duration: AppDurations.pageScroll,
      curve: Curves.easeOutCubic,
    );
  }

  void _onTapCard() {
    final target = _targetCount(_currentIndex);
    final isComplete = _progress[_currentIndex] >= target;

    if (isComplete) {
      if (_currentIndex < widget.zekr.length - 1) {
        HapticFeedback.lightImpact();
        _goToIndex(_currentIndex + 1);
      }
      return;
    }

    HapticFeedback.lightImpact();
    setState(() {
      _progress[_currentIndex]++;
    });

    if (_progress[_currentIndex] >= target &&
        _currentIndex < widget.zekr.length - 1) {
      Future.delayed(AppDurations.pageScroll, () {
        if (!mounted) return;
        _goToIndex(_currentIndex + 1);
      });
    }
  }

  String _statusLabel(AppLocalizations l10n, _ZekrStatus status) {
    return switch (status) {
      _ZekrStatus.completed => l10n.zekrCompleted,
      _ZekrStatus.inProgress => l10n.zekrInProgress,
      _ZekrStatus.notStarted => l10n.zekrNotStarted,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final completed = _completedItemsCount();

    return Scaffold(
      appBar: CustomAppbar(
        title: Column(
          children: [
            Text(
              widget.title,
              style: AppTextStyles.textStyleFont20.copyWith(fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              l10n.zekrCompletedSummary(completed, widget.zekr.length),
              style: TextStyle(
                fontSize: 11,
                color: scheme.onSurface.withOpacity(0.55),
                height: 1.1,
              ),
            ),
          ],
        ),
        leading: const BuildIconBackWidget(),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                minHeight: 4,
                value: widget.zekr.isEmpty ? 0 : completed / widget.zekr.length,
                backgroundColor: scheme.outline.withOpacity(0.12),
              ),
            ),
          ),
          SizedBox(
            height: 46,
            child: ListView.separated(
              controller: _chipScrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: widget.zekr.length,
              separatorBuilder: (_, __) => const SizedBox(width: 6),
              itemBuilder: (context, index) {
                return _ZekrStepChip(
                  index: index,
                  selected: index == _currentIndex,
                  status: _statusFor(index),
                  current: _progress[index],
                  target: _targetCount(index),
                  onTap: () => _goToIndex(index),
                );
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: _onTapCard,
              behavior: HitTestBehavior.opaque,
              child: PageView.builder(
                controller: _pageController,
                physics: const FastPageScrollPhysics(),
                itemCount: widget.zekr.length,
                onPageChanged: _onIndexChanged,
                itemBuilder: (context, index) {
                  final item = widget.zekr[index];
                  final target = _targetCount(index);
                  final current = _progress[index];
                  final status = _statusFor(index);

                  return Padding(
                    padding:
                        HomeFeatureUi.pagePadding.copyWith(top: 8, bottom: 0),
                    child: AnimatedContainer(
                      duration: AppDurations.micro,
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                      decoration: HomeFeatureUi.neutralCardDecoration(
                        context,
                        selected: index == _currentIndex,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.rtl,
                            children: [
                              _StatusPill(
                                label: _statusLabel(l10n, status),
                                status: status,
                              ),
                              Text(
                                l10n.zekrSequence(
                                  index + 1,
                                  widget.zekr.length,
                                ),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: scheme.onSurface.withOpacity(0.55),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Expanded(
                            child: Center(
                              child: SingleChildScrollView(
                                physics: const ClampingScrollPhysics(),
                                child: Text(
                                  item.text,
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: AppTextStyles.textStyleFont20.copyWith(
                                    fontSize: 20,
                                    height: 1.65,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          _RepeatProgress(
                            current: current,
                            target: target,
                            countLabel: l10n.howOfen,
                            repeatLabel: l10n.zekrRepeatCount(current, target),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: _onTapCard,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
              child: Row(
                children: [
                  _NavButton(
                    icon: Icons.chevron_right_rounded,
                    enabled: _currentIndex > 0,
                    onPressed: () => _goToIndex(_currentIndex - 1),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          l10n.zekrTapHint,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 12,
                            color: scheme.onSurface.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.zekrRepeatCount(
                            _progress[_currentIndex],
                            _targetCount(_currentIndex),
                          ),
                          style: AppTextStyles.textStyleFont30.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            height: 1,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _NavButton(
                    icon: Icons.chevron_left_rounded,
                    enabled: _currentIndex < widget.zekr.length - 1,
                    onPressed: () => _goToIndex(_currentIndex + 1),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _ZekrStepChip extends StatelessWidget {
  const _ZekrStepChip({
    required this.index,
    required this.selected,
    required this.status,
    required this.current,
    required this.target,
    required this.onTap,
  });

  final int index;
  final bool selected;
  final _ZekrStatus status;
  final int current;
  final int target;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isComplete = status == _ZekrStatus.completed;
    final isProgress = status == _ZekrStatus.inProgress;

    Color borderColor;
    Color fillColor;
    Color textColor;

    if (isComplete) {
      borderColor = scheme.primary.withOpacity(0.5);
      fillColor = scheme.primary.withOpacity(0.14);
      textColor = scheme.primary;
    } else if (isProgress) {
      borderColor = scheme.tertiary.withOpacity(0.45);
      fillColor = scheme.tertiary.withOpacity(0.12);
      textColor = scheme.tertiary;
    } else {
      borderColor = scheme.outline.withOpacity(0.22);
      fillColor = scheme.surface;
      textColor = scheme.onSurface.withOpacity(0.55);
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: AppDurations.micro,
          padding: EdgeInsets.symmetric(
            horizontal: selected ? 10 : 8,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? scheme.primary : borderColor,
              width: selected ? 1.4 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isComplete)
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 4),
                  child: Icon(
                    Icons.check_rounded,
                    size: 14,
                    color: textColor,
                  ),
                ),
              Text(
                isProgress ? '$current/$target' : '${index + 1}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({
    required this.label,
    required this.status,
  });

  final String label;
  final _ZekrStatus status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final Color color;
    final Color bg;

    switch (status) {
      case _ZekrStatus.completed:
        color = scheme.primary;
        bg = scheme.primary.withOpacity(0.12);
      case _ZekrStatus.inProgress:
        color = scheme.tertiary;
        bg = scheme.tertiary.withOpacity(0.12);
      case _ZekrStatus.notStarted:
        color = scheme.onSurface.withOpacity(0.55);
        bg = scheme.surfaceContainerHighest;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
          height: 1,
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}

class _RepeatProgress extends StatelessWidget {
  const _RepeatProgress({
    required this.current,
    required this.target,
    required this.countLabel,
    required this.repeatLabel,
  });

  final int current;
  final int target;
  final String countLabel;
  final String repeatLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final value = target == 0 ? 0.0 : (current / target).clamp(0.0, 1.0);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl,
          children: [
            Text(
              countLabel,
              style: TextStyle(
                fontSize: 12,
                color: scheme.onSurface.withOpacity(0.55),
              ),
            ),
            Text(
              repeatLabel,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            minHeight: 5,
            value: value,
            backgroundColor: scheme.outline.withOpacity(0.12),
          ),
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.enabled,
    required this.onPressed,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: enabled ? onPressed : null,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        minimumSize: const Size(42, 42),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(HomePrayerUi.radius),
          side: BorderSide(
            color: scheme.outline.withOpacity(enabled ? 0.2 : 0.08),
          ),
        ),
        backgroundColor: enabled
            ? scheme.surfaceContainerHighest
            : scheme.surfaceContainerHighest.withOpacity(0.35),
        foregroundColor:
            enabled ? scheme.onSurface : scheme.onSurface.withOpacity(0.25),
      ),
    );
  }
}
