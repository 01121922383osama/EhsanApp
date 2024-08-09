import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../config/routes/routes_name.dart';
import '../../../../core/extension/extension.dart';
import '../../../../core/utils/assets_svg.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../Setting/presentation/cubit/Theme/theme_cubit.dart';
import '../widgets/build_menu_button_bar_widget.dart';

import '../../../Library/presentation/pages/library_page.dart';
import '../../../Listen/presentation/pages/listen_page.dart';
import '../../../Setting/presentation/pages/profile_page.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../cubit/app_cubit.dart';
import '../widgets/build_nav_widget.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppbar(
            leading: IconButton.outlined(
              onPressed: () {
                context.pushNamed(pageRoute: RoutesName.aboutUs);
              },
              icon: BlocBuilder<ThemeCubit, bool>(
                builder: (context, state) {
                  return SvgPicture.asset(
                    AssetsSvg.icon4,
                    fit: BoxFit.cover,
                    color: context.read<ThemeCubit>().state
                        ? Colors.white
                        : Colors.black,
                  );
                },
              ),
            ),
            actions: [
              buildMenu(context, state),
            ],
          ),
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return true;
            },
            child: PageView(
              controller: context.read<AppCubit>().pageController,
              onPageChanged: (value) {
                context.read<AppCubit>().changeIndex(value);
              },
              children: _widgets,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: BuildNavWidget(
            state: state,
            pageController: context.read<AppCubit>().pageController,
          ),
        );
      },
    );
  }
}

List<Widget> _widgets = [
  const HomePage(),
  const LibraryPage(),
  const ListenPage(),
  const ProfilePage(),
];
