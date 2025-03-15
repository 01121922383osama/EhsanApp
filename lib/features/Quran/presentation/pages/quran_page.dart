import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/widgets/build_leading_widget.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../widgets/build_sora_widget.dart';
import '../widgets/search_delegate.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        leading: const BuildIconBackWidget(),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.holyQuran,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          BuildIconBackWidget(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchQuran());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Scrollbar(
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
    );
  }
}
