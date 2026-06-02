import 'package:flutter/material.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../data/models/category_model.dart';
import '../../data/services/library_service.dart';
import '../widgets/base_category_page.dart';
import '../widgets/library_item_builders.dart';

class RamadanPage extends StatelessWidget {
  const RamadanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCategoryPage(
      title: AppLocalizations.of(context)!.ramadan,
      icon: Icons.nightlight_round_rounded,
      loadCategories: LibraryService().getRamadan,
      buildDetailPage: (context, category) => RamadanDetailPage(category: category),
    );
  }
}

class RamadanDetailPage extends StatelessWidget {
  final CategoryModel category;

  const RamadanDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BaseCategoryDetailPage(
      category: category,
      buildItemWidget: buildLibraryTextItem,
    );
  }
}
