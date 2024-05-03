import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubit/app_cubit.dart';
import 'build_icon_nav.dart';

class BuildNavWidget extends StatelessWidget {
  final AppState state;
  const BuildNavWidget({super.key, required this.state});

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
            state: state,
            index: 0,
            iconOne: Icons.home,
            iconTwo: CupertinoIcons.home,
          ),
          BuildIconNav(
            state: state,
            index: 1,
            iconOne: Icons.library_books,
            iconTwo: Icons.library_books_outlined,
          ),
          BuildIconNav(
            state: state,
            index: 2,
            iconOne: Icons.podcasts,
            iconTwo: Icons.podcasts_outlined,
          ),
          BuildIconNav(
            state: state,
            index: 3,
            iconOne: CupertinoIcons.person_crop_circle_fill,
            iconTwo: CupertinoIcons.profile_circled,
          ),
        ],
      ),
    );
  }
}
