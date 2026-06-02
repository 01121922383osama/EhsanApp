import 'package:flutter/material.dart';

import '../../../widgets/home_feature_ui.dart';
class DetailsAmaaHosna extends StatelessWidget {
  const DetailsAmaaHosna({
    super.key,
    required this.index,
    required this.name,
    required this.text,
  });

  final int index;
  final String name;
  final String text;

  @override
  Widget build(BuildContext context) {
    return HomeFeatureUi.asmaaCard(
      context: context,
      index: index,
      name: name,
      text: text,
    );
  }
}
