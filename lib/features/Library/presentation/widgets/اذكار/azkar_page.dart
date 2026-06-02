import 'package:flutter/material.dart';
import 'package:free_lancer/l10n/app_localizations.dart';
import '../../../data/models/category_model.dart';
import '../../../data/services/library_service.dart';

class AzkarPage extends StatelessWidget {
  const AzkarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final libraryService = LibraryService();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.azkar),
      ),
      body: FutureBuilder<List<CategoryModel>>(
        future: libraryService.getAzkar(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                textDirection: TextDirection.rtl,
              ),
            );
          }

          final categories = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AzkarDetailPage(category: category),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          category.category,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${category.items.length} عنصر',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 14,
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AzkarDetailPage extends StatelessWidget {
  final CategoryModel category;

  const AzkarDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.category,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: category.items.length,
        itemBuilder: (context, index) {
          final item = category.items[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
                  if (item.count > 1) ...[
                    const SizedBox(height: 8),
                    Text(
                      'عدد المرات: ${item.count}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                      ),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
