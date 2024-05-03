import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:free_lancer/features/home/presentation/widgets/about_us.dart';

import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_svg.dart';
import '../../../Listen/presentation/widgets/build_menu_alshai5.dart';
import '../../../app/presentation/cubit/app_cubit.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppState state;
  const BuildAppBar({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(15, 15),
        ),
      ),
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _openBottomSheet(context),
                child: SvgPicture.asset(
                  AssetsSvg.icon4,
                ),
              ),
              state.index != 2
                  ? IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_active),
                    )
                  : IconButton(
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: SearchMoshaf(),
                        );
                      },
                      icon: const Icon(Icons.search),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}

void _openBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: context.width / 2.3,
              child: const AboutUsWidget(
                image: AssetsSvg.osama,
                name: 'Osama Nabil',
                jobTitle: 'Flutter Developer',
                description:
                    '''This text is an example of text that can be replaced in the same space. This text was generated from the Arabic text generator, where you can generate such text or many other texts in addition to increasing the number of letters that the application generates.''',
              ),
            ),
            const SizedBox(width: 5),
            SizedBox(
              width: context.width / 2.3,
              child: const AboutUsWidget(
                image: AssetsSvg.bilal,
                name: 'Bilal Reda',
                jobTitle: 'Ui / Ux Designer',
                description:
                    '''This text is an example of text that can be replaced in the same space. This text was generated from the Arabic text generator, where you can generate such text or many other texts in addition to increasing the number of letters that the application generates.''',
              ),
            ),
          ],
        ),
      );
    },
  );
}
