import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_appbar.dart';

class SeraNabwya extends StatelessWidget {
  final String title;
  const SeraNabwya({super.key, required this.title});

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
