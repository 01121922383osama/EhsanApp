import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/build_leading_widget.dart';
import '../../../../core/widgets/space_widget.dart';
import '../../../Setting/presentation/cubit/Theme/theme_cubit.dart';
import '../widgets/details_surah.dart';

class SurahPage extends StatelessWidget {
  final String? suraName;
  final int? indexOfSurah;
  const SurahPage({super.key, this.suraName, this.indexOfSurah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              leading: const Padding(
                padding: EdgeInsets.all(4),
                child: BuildIconBackWidget(),
              ),
              title: Text(suraName!),
              centerTitle: true,
              backgroundColor: context.read<ThemeCubit>().state
                  ? AppColors.transparent
                  : AppColors.white,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(8),
                ),
              ),
            ),
            const SpaceWidget(height: 15),
            SliverToBoxAdapter(
              child: indexOfSurah != 0 && indexOfSurah != 8
                  ? Center(
                      child: SvgPicture.asset(
                        'assets/svg/besmAllah.svg',
                        fit: BoxFit.scaleDown,
                        height: 55,
                        color: context.read<ThemeCubit>().state
                            ? AppColors.white
                            : AppColors.black,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            DetailsSurahWidget(
              indexOfSurah: indexOfSurah,
            ),
          ],
        ),
      ),
    );
  }
}
