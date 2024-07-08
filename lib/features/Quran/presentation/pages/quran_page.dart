import 'package:flutter/material.dart';
import '../widgets/search_delegate.dart';

import '../../../../core/widgets/build_leading_widget.dart';
import '../widgets/build_sora_widget.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BuildIconBackWidget(),
                  IconButton.filledTonal(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      showSearch(context: context, delegate: SearchQuran());
                    },
                  ),
                ],
              ),
              Expanded(
                child: Scrollbar(
                  child: NotificationListener<OverscrollIndicatorNotification>(
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
    );
  }
}
