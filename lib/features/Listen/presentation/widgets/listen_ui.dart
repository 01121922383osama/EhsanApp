import 'package:flutter/material.dart';

import '../../../home/presentation/widgets/home_feature_ui.dart';
import '../../../home/presentation/widgets/home_prayer_ui.dart';

abstract final class ListenUi {
  static Widget sectionHeader(BuildContext context, String title) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 2, 4, HomePrayerUi.sectionTitleGap),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Icon(
            Icons.graphic_eq_rounded,
            size: 16,
            color: scheme.primary,
          ),
          const SizedBox(width: 6),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  height: 1.1,
                ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  static Widget heroCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    Widget? visualizer,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      decoration: HomeFeatureUi.neutralCardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
            textDirection: TextDirection.rtl,
          ),
          if (visualizer != null) ...[
            const SizedBox(height: 10),
            SizedBox(
              height: 44,
              width: double.infinity,
              child: visualizer,
            ),
          ],
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurface.withOpacity(0.72),
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
          ),
        ],
      ),
    );
  }

  static Widget quickActionButton({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(HomePrayerUi.radius),
        child: Ink(
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(HomePrayerUi.radius),
            color: scheme.surfaceContainerHighest,
            border: Border.all(color: scheme.outline.withOpacity(0.12)),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
      ),
    );
  }

  static Widget playerPanel(
    BuildContext context, {
    required Widget child,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        border: Border(
          top: BorderSide(color: scheme.outline.withOpacity(0.12)),
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
          child: child,
        ),
      ),
    );
  }

  static Widget controlIconButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback? onPressed,
    double size = 40,
    String? label,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: onPressed,
      icon: label != null
          ? Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: onPressed != null
                    ? scheme.onSurface
                    : scheme.onSurface.withOpacity(0.35),
              ),
            )
          : Icon(
              icon,
              size: 22,
              color: onPressed != null
                  ? scheme.onSurface
                  : scheme.onSurface.withOpacity(0.35),
            ),
      style: IconButton.styleFrom(
        minimumSize: Size(size, size),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(HomePrayerUi.radius),
        ),
      ),
    );
  }
}
