import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/widgets/custom_appbar.dart';

abstract class BaseLibraryPage extends StatelessWidget {
  final String title;
  final String jsonPath;

  const BaseLibraryPage({
    super.key,
    required this.title,
    required this.jsonPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: true,
        title: Text(title)
            .animate()
            .fadeIn(duration: 50.ms)
            .slideX(begin: -0.2, end: 0, duration: 50.ms),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: loadData(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ).animate().fadeIn(duration: 50.ms);
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            ).animate().fadeIn(duration: 50.ms);
          }

          final items = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return buildListItem(context, items[index], index)
                  .animate()
                  .fadeIn(delay: (25 * index).ms, duration: 50.ms)
                  .slideX(begin: 0.2, end: 0, duration: 50.ms);
            },
          );
        },
      ),
    );
  }

  Widget buildListItem(BuildContext context, dynamic item, int index);

  Future<List<dynamic>> loadData() async {
    String jsonString = await rootBundle.loadString(jsonPath);
    return json.decode(jsonString);
  }
}
