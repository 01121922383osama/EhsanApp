import 'package:flutter/material.dart';

import '../base_library_page.dart';

class Ad3yaPage extends BaseLibraryPage {
  const Ad3yaPage({super.key, required super.title})
      : super(
          jsonPath: 'assets/jsons/ad3ya/أدعية عامة.json',
        );

  @override
  Widget buildListItem(BuildContext context, dynamic item, int index) {
    final dua = Dua.fromJson(item);
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.1),
              Theme.of(context).primaryColor.withOpacity(0.05),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Text(
          dua.text,
          style: const TextStyle(
            fontSize: 18,
            height: 1.8,
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}

class Dua {
  final String text;
  Dua({required this.text});
  factory Dua.fromJson(Map<String, dynamic> json) {
    return Dua(text: json['text']);
  }
}
