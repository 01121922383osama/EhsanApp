import 'package:flutter/material.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../data/models/category_model.dart';
import '../../data/services/library_service.dart';
import '../widgets/base_category_page.dart';
import '../widgets/library_item_builders.dart';

class Ad3yaPage extends StatelessWidget {
  const Ad3yaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCategoryPage(
      title: AppLocalizations.of(context)!.ad3ya,
      icon: Icons.favorite_rounded,
      loadCategories: LibraryService().getAdiya,
      buildDetailPage: (context, category) => Ad3yaDetailPage(category: category),
    );
  }
}

class Ad3yaDetailPage extends StatelessWidget {
  final CategoryModel category;

  const Ad3yaDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BaseCategoryDetailPage(
      category: category,
      buildItemWidget: buildLibraryTextItem,
    );
  }
}
