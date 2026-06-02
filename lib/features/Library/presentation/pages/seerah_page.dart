import 'package:flutter/material.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../data/models/category_model.dart';
import '../../data/services/library_service.dart';
import '../widgets/base_category_page.dart';
import '../widgets/library_item_builders.dart';

class SeerahPage extends StatelessWidget {
  const SeerahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCategoryPage(
      title: AppLocalizations.of(context)!.seerah,
      icon: Icons.history_edu_rounded,
      loadCategories: LibraryService().getSeerah,
      buildDetailPage: (context, category) => SeerahDetailPage(category: category),
    );
  }
}

class SeerahDetailPage extends StatelessWidget {
  final CategoryModel category;

  const SeerahDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BaseCategoryDetailPage(
      category: category,
      buildItemWidget: buildLibrarySeerahItem,
    );
  }
}
