import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubit/app_cubit.dart';
import 'build_icon_nav.dart';

class BuildNavWidget extends StatelessWidget {
  final AppState state;
  final PageController pageController;
  const BuildNavWidget(
      {super.key, required this.state, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.lightgray.withOpacity(0.6),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ButtonBar(
        alignment: MainAxisAlignment.spaceEvenly,
        children: [
          BuildIconNav(
            tooltip: AppLocalizations.of(context)!.home,
            state: state,
            index: 0,
            pageController: pageController,
            iconOne: Icons.home,
            iconTwo: CupertinoIcons.home,
          ),
          BuildIconNav(
            tooltip: AppLocalizations.of(context)!.books,
            state: state,
            index: 1,
            pageController: pageController,
            iconOne: Icons.library_books,
            iconTwo: Icons.library_books_outlined,
          ),
          BuildIconNav(
            tooltip: AppLocalizations.of(context)!.listen,
            state: state,
            index: 2,
            pageController: pageController,
            iconOne: Icons.podcasts,
            iconTwo: Icons.podcasts_outlined,
          ),
          BuildIconNav(
            tooltip: AppLocalizations.of(context)!.profile,
            state: state,
            index: 3,
            pageController: pageController,
            iconOne: CupertinoIcons.person_crop_circle_fill,
            iconTwo: CupertinoIcons.profile_circled,
          ),
        ],
      ),
    );
  }
}
