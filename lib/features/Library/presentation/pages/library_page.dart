import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/extension/extension.dart';
import '../../../../core/widgets/space_widget.dart';
import '../widgets/build_list_books.dart';
import '../widgets/build_other_books.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SpaceWidget(height: 20),
            const BuildListBooks(),
            const SpaceWidget(height: 16),
            const BuildOtherBooks(),
            SpaceWidget(height: context.width / 4),
          ],
        ).animate().fadeIn(
              duration: 50.ms,
              curve: Curves.easeOut,
            ),
      ),
    );
  }
}
