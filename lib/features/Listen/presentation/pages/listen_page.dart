import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../cubit/listen_cubit.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../Setting/presentation/cubit/Theme/theme_cubit.dart';
import '../widgets/build_first_widget.dart';
import '../widgets/build_menu_alshai5.dart';

class ListenPage extends StatelessWidget {
  const ListenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
       create: (context) => ListenCubit(),
      child: Scaffold(
        backgroundColor: context.read<ThemeCubit>().state
            ? AppColors.black.withOpacity(0.2)
            : null,
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowIndicator();
              return false;
            },
            child: CustomScrollView(
              primary: true,
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                const BuildFirstWidget(),
                SliverToBoxAdapter(
                  child: Text(
                    AppLocalizations.of(context)!.popular,
                    style: TextStyle(
                      color: context.read<ThemeCubit>().state
                          ? AppColors.white
                          : AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const BuildMenuShai5(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
