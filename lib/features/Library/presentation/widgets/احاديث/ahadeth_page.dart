import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../Quran/presentation/widgets/leading_widget.dart';

import '../../../../../core/widgets/custom_appbar.dart';

class Hadith {
  final String text;
  Hadith({required this.text});
  factory Hadith.fromJson(Map<String, dynamic> json) {
    return Hadith(
      text: json['text'],
    );
  }
}

class AhadethPage extends StatelessWidget {
  final String title;
  const AhadethPage({super.key, required this.title});

  Future<List<Hadith>> loadAhadith() async {
    String jsonString =
        await rootBundle.loadString('assets/jsons/ahadith/أحاديث عامة.json');

    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => Hadith.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: true,
        title: Text(title),
      ),
      body: FutureBuilder<List<Hadith>>(
        future: loadAhadith(),
        builder: (BuildContext context, AsyncSnapshot<List<Hadith>> snapshot) {
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
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Hadith> ahadith = snapshot.data ?? [];
            return ListView.builder(
              itemCount: ahadith.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: LeadingWidget(index: index),
                  title: Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        ahadith[index].text,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}
