import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/extension/blurry_widget.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubit/app_cubit.dart';
import 'build_icon_nav.dart';

class BuildNavWidget extends StatelessWidget {
  final AppState state;
  final PageController pageController;
  const BuildNavWidget({
    super.key,
    required this.state,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        height: 65,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 2.0,
                  sigmaY: 2.0,
                ),
                child: Container(),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: AppColors.white.withOpacity(0.3)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.darkBlue.withOpacity(0.2),
                      AppColors.darkBlue.withOpacity(0.2),
                    ],
                  ),
                ),
              ),
              ButtonBar(
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
            ],
          ).blurry(),
        ),
      ),
    );
  }
}
