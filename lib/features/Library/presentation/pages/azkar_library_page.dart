import 'package:flutter/material.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../data/models/category_model.dart';
import '../../data/services/library_service.dart';
import '../widgets/base_category_page.dart';
import '../widgets/library_item_builders.dart';

class AzkarLibraryPage extends StatelessWidget {
  const AzkarLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCategoryPage(
      title: AppLocalizations.of(context)!.azkar,
      icon: Icons.menu_book_rounded,
      loadCategories: LibraryService().getAzkar,
      buildDetailPage: (context, category) => AzkarDetailPage(category: category),
    );
  }
}

class AzkarDetailPage extends StatelessWidget {
  final CategoryModel category;

  const AzkarDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BaseCategoryDetailPage(
      category: category,
      buildItemWidget: buildLibraryAzkarItem,
    );
  }
}
