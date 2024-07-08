import 'package:flutter/material.dart';

import '../../../../../core/widgets/build_leading_widget.dart';

class DoaaPage extends StatelessWidget {
  const DoaaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BuildIconBackWidget(),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
