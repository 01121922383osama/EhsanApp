import 'package:flutter/material.dart';

import '../../../../core/extension/extension.dart';
import '../../../../core/widgets/custom_search.dart';
import '../../../../core/widgets/space_widget.dart';
import '../widgets/build_list_books.dart';
import '../widgets/build_other_books.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(
                child: CustomSearchWidget(
                  hintText: 'Search...',
                ),
              ),
              const SpaceWidget(height: 20),
              const BuildListBooks(),
              const SpaceWidget(height: 20),
              const BuildOtherBooks(),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: context.width / 4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
