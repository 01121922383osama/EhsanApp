import 'package:flutter/material.dart';
import 'package:free_lancer/l10n/app_localizations.dart';
import '../../../data/models/category_model.dart';
import '../../../data/services/library_service.dart';
import '../base_category_page.dart';

class AhadethPage extends StatelessWidget {
  const AhadethPage({super.key});

  @override
  Widget build(BuildContext context) {
    final libraryService = LibraryService();

    return BaseCategoryPage(
      title: AppLocalizations.of(context)!.ahadeth,
      icon: Icons.auto_stories_rounded,
      loadCategories: libraryService.getAhadethCategories,
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
      buildItemWidget: (context, item) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            item.text,
            style: const TextStyle(
              fontSize: 18,
              height: 1.5,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
          if (item.source != null && item.source!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'المصدر: ${item.source}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
            ),
          ],
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
