import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Library/presentation/pages/library_page.dart';
import '../../../Listen/presentation/pages/listen_page.dart';
import '../../../Setting/presentation/pages/profile_page.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../home/presentation/widgets/build_app_widget.dart';
import '../cubit/app_cubit.dart';
import '../widgets/build_nav_widget.dart';

class AppPage extends StatelessWidget {
  AppPage({super.key});
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: BuildAppBar(state: state),
          body: PageView(
            controller: _pageController,
            onPageChanged: (value) {
              context.read<AppCubit>().changeIndex(value);
            },
            children: _widgets,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: BuildNavWidget(
            state: state,
            pageController: _pageController,
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
