import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../../../config/routes/routes_name.dart';
import '../../../../core/extension/extension.dart';
import 'build_grid_book_tile.dart';

class BuildOtherBooks extends StatelessWidget {
  const BuildOtherBooks({super.key});

  @override
  Widget build(BuildContext context) {
    final items = _items(context);

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.95,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final item = items[index];
            return BuildGridBookTile(
              title: item.title,
              icon: item.icon,
              onTap: () => context.pushNamed(pageRoute: item.route),
            ).animate(delay: (50 * index).ms).fadeIn(duration: 50.ms).scale(
                  begin: const Offset(0.92, 0.92),
                  end: const Offset(1, 1),
                  duration: 50.ms,
                );
          },
          childCount: items.length,
        ),
      ),
    );
  }

  List<_LibraryGridItem> _items(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      _LibraryGridItem(
        title: l10n.ahadeth,
        icon: Icons.auto_stories_rounded,
        route: RoutesName.ahadethPage,
      ),
      _LibraryGridItem(
        title: l10n.azkar,
        icon: Icons.menu_book_rounded,
        route: RoutesName.azkarPage,
      ),
      _LibraryGridItem(
        title: l10n.ad3ya,
        icon: Icons.favorite_rounded,
        route: RoutesName.ad3yaPage,
      ),
      _LibraryGridItem(
        title: l10n.hajj,
        icon: Icons.mosque_rounded,
        route: RoutesName.hajjPage,
      ),
      _LibraryGridItem(
        title: l10n.seerah,
        icon: Icons.history_edu_rounded,
        route: RoutesName.seerahPage,
      ),
      _LibraryGridItem(
        title: l10n.ramadan,
        icon: Icons.nightlight_round_rounded,
        route: RoutesName.ramadanPage,
      ),
    ];
  }
}

class _LibraryGridItem {
  final String title;

  final IconData icon;
  final String route;
  const _LibraryGridItem({
    required this.title,
    required this.icon,
    required this.route,
  });
}
