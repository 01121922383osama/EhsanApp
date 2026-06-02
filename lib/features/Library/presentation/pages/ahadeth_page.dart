import 'package:flutter/material.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../data/models/category_model.dart';
import '../../data/services/library_service.dart';
import '../widgets/base_category_page.dart';
import '../widgets/library_item_builders.dart';

class AhadethPage extends StatelessWidget {
  const AhadethPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCategoryPage(
      title: AppLocalizations.of(context)!.ahadeth,
      icon: Icons.auto_stories_rounded,
      loadCategories: LibraryService().getAhadethCategories,
      buildDetailPage: (context, category) => AhadethDetailPage(category: category),
    );
  }
}

class AhadethDetailPage extends StatelessWidget {
  final CategoryModel category;

  const AhadethDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BaseCategoryDetailPage(
      category: category,
      buildItemWidget: buildLibraryHadithItem,
    );
  }
}
