import 'package:flutter/material.dart';

import '../../../../core/utils/app_styles.dart';
import 'home_prayer_ui.dart';

abstract final class HomeFeatureUi {
  static const pagePadding = EdgeInsets.fromLTRB(12, 6, 12, 16);

  static Widget compactLoading() {
    return const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  static Widget emptyState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 40,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  static BoxDecoration neutralCardDecoration(
    BuildContext context, {
    bool selected = false,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return BoxDecoration(
      borderRadius: BorderRadius.circular(HomePrayerUi.radius),
      color: selected ? scheme.surfaceContainerHighest : scheme.surface,
      border: Border.all(
        color: selected
            ? scheme.primary.withOpacity(0.35)
            : scheme.outline.withOpacity(0.14),
        width: selected ? 1.2 : 1,
      ),
      boxShadow: [
        BoxShadow(
          color: scheme.shadow.withOpacity(0.05),
          blurRadius: selected ? 10 : 6,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  static Widget indexBadge(BuildContext context, int index) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: scheme.surfaceContainerHighest,
        border: Border.all(color: scheme.outline.withOpacity(0.18)),
      ),
      child: Text(
        '${index + 1}',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: scheme.onSurface,
          height: 1,
        ),
      ),
    );
  }

  static Widget categoryTile({
    required BuildContext context,
    required int index,
    required String title,
    required VoidCallback onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: HomePrayerUi.itemGap),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(HomePrayerUi.radius),
          child: Ink(
            height: HomePrayerUi.listRowHeight,
            padding: const EdgeInsets.symmetric(
              horizontal: HomePrayerUi.horizontalInset,
            ),
            decoration: neutralCardDecoration(context),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                indexBadge(context, index),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.textStyleFont15WoColor.copyWith(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.15,
                    ),
                    textDirection: TextDirection.rtl,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.chevron_left_rounded,
                  color: scheme.onSurface.withOpacity(0.45),
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget asmaaCard({
    required BuildContext context,
    required int index,
    required String name,
    required String text,
  }) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: HomePrayerUi.itemGap),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: neutralCardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              indexBadge(context, index),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  name,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: AppTextStyles.textStyleFont20.copyWith(
                    color: scheme.onSurface,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Divider(
              height: 1,
              color: scheme.outline.withOpacity(0.12),
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: AppTextStyles.textStyleFont15WoColor.copyWith(
              color: scheme.onSurface.withOpacity(0.82),
              fontSize: 14,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  static Widget surfacePanel(
    BuildContext context, {
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(10),
    Color? accent,
  }) {
    final color = accent ?? Theme.of(context).colorScheme.primary;
    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: HomePrayerUi.itemGap),
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(HomePrayerUi.radius),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: color.withOpacity(0.16)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
