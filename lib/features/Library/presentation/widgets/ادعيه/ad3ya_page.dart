import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_appbar.dart';

class Ad3yaPage extends StatelessWidget {
  final String title;
  const Ad3yaPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: true,
        title: Text(title),
      ),
    );
  }
}
