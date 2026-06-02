import 'package:flutter/material.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../data/models/hadith_model.dart';
import '../../data/services/library_service.dart';

class AhadithPage extends StatelessWidget {
  const AhadithPage({super.key});

  @override
  Widget build(BuildContext context) {
    final libraryService = LibraryService();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.ahadith),
      ),
      body: FutureBuilder<List<HadithModel>>(
        future: libraryService.getAhadith(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                textDirection: TextDirection.rtl,
              ),
            );
          }
          final ahadith = snapshot.data!;
          return ListView.builder(
            itemCount: ahadith.length,
            itemBuilder: (context, index) {
              final hadith = ahadith[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title: Text(
                    hadith.number,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            hadith.label,
                            style: const TextStyle(fontSize: 16),
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                          ),
                          if (hadith.text.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              hadith.text,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
