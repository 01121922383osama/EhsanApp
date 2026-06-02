import 'package:flutter/material.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../../data/models/category_model.dart';
import '../../../data/services/library_service.dart';
import '../base_category_page.dart';

class SeerahDetailPage extends StatelessWidget {
  final CategoryModel category;

  const SeerahDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BaseCategoryDetailPage(
      category: category,
      buildItemWidget: (context, item) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (item.title != null && item.title!.isNotEmpty) ...[
            Text(
              item.title!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 12),
          ],
          Text(
            item.text,
            style: const TextStyle(
              fontSize: 18,
              height: 1.5,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
          if (item.description != null && item.description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              item.description!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 14,
                height: 1.4,
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
            ),
          ],
        ],
      ),
    );
  }
}

class SeerahPage extends StatelessWidget {
  const SeerahPage({super.key});

  @override
  Widget build(BuildContext context) {
    final libraryService = LibraryService();

    return BaseCategoryPage(
      title: AppLocalizations.of(context)!.seerah,
      icon: Icons.history_edu_rounded,
      loadCategories: libraryService.getSeerah,
      buildDetailPage: (context, category) =>
          SeerahDetailPage(category: category),
    );
  }
}
