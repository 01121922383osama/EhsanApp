import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../../../core/extension/extension.dart';
import '../../../Quran/presentation/pages/quran_page.dart';
import 'build_list_widgtet.dart';

class BuildListBooks extends StatelessWidget {
  const BuildListBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          BuildListTileWidget(
            titlel: AppLocalizations.of(context)!.holyQuran,
            trailing: Icon(
              Icons.menu_book_rounded,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
            onTap: () => context.push(widget: const QuranPage()),
          ),
        ]
            .animate(interval: 50.ms)
            .fadeIn(duration: 50.ms)
            .slideX(begin: 0.2, end: 0, duration: 50.ms),
      ),
    );
  }
}
