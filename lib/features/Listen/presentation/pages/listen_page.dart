import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../../home/presentation/widgets/home_feature_ui.dart';
import '../cubit/listen_cubit.dart';
import '../widgets/build_first_widget.dart';
import '../widgets/build_menu_alshai5.dart';
import '../widgets/listen_ui.dart';
import '../widgets/social_videos.dart';

class ListenPage extends StatelessWidget {
  const ListenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListenCubit(),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return false;
        },
        child: CustomScrollView(
          primary: true,
          physics: const BouncingScrollPhysics(),
          slivers: [
            const BuildFirstWidget(),
            SliverPadding(
              padding: HomeFeatureUi.pagePadding.copyWith(top: 5, bottom: 5),
              sliver: const SliverToBoxAdapter(
                child: SocialVideos(),
              ),
            ),
            SliverPadding(
              padding: HomeFeatureUi.pagePadding.copyWith(top: 5, bottom: 5),
              sliver: SliverToBoxAdapter(
                child: ListenUi.sectionHeader(
                  context,
                  AppLocalizations.of(context)!.popular,
                ),
              ),
            ),
            const BuildMenuShai5(),
          ],
        ),
      ),
    );
  }
}
