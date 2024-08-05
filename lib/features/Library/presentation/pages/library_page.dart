import 'package:flutter/material.dart';

import '../../../../core/extension/extension.dart';
import '../../../../core/widgets/space_widget.dart';
import '../widgets/build_list_books.dart';
import '../widgets/build_other_books.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return false;
        },
        child: CustomScrollView(
          primary: true,
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SpaceWidget(height: 15),
            const BuildListBooks(),
            const SpaceWidget(height: 20),
            const BuildOtherBooks(),
            SpaceWidget(height: context.width / 4),
          ],
        ),
      ),
    );
  }
}
