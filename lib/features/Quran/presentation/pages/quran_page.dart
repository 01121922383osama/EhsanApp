import 'package:flutter/material.dart';
import '../../../../core/extension/blurry_widget.dart';
import '../../../../core/widgets/animation_colors.dart';

import '../../../../core/widgets/build_leading_widget.dart';
import '../widgets/build_sora_widget.dart';
import '../widgets/search_delegate.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationColorsContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BuildIconBackWidget().blurry(),
                    BuildIconBackWidget(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        showSearch(context: context, delegate: SearchQuran());
                      },
                    ).blurry(),
                  ],
                ),
                Expanded(
                  child: Scrollbar(
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowIndicator();
                        return false;
                      },
                      child: CustomScrollView(
                        primary: true,
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          BuildSoraNamesWidget(
                            quranList: quranList,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
