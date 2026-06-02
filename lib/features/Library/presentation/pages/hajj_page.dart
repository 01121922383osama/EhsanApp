import 'package:flutter/material.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../data/models/category_model.dart';
import '../../data/services/library_service.dart';
import '../widgets/base_category_page.dart';
import '../widgets/library_item_builders.dart';

class HajjPage extends StatelessWidget {
  const HajjPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCategoryPage(
      title: AppLocalizations.of(context)!.hajj,
      icon: Icons.mosque_rounded,
      loadCategories: LibraryService().getHajj,
      buildDetailPage: (context, category) => HajjDetailPage(category: category),
    );
  }
}

class HajjDetailPage extends StatelessWidget {
  final CategoryModel category;

  const HajjDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BaseCategoryDetailPage(
      category: category,
      buildItemWidget: buildLibrarySeerahItem,
    );
  }
}
