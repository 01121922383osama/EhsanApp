import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:free_lancer/features/Quran/presentation/widgets/build_avatar_surah.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/build_leading_widget.dart';
import '../../../Setting/presentation/cubit/Theme/theme_cubit.dart';
import '../pages/Hadith/models/array.dart';

class DetailsOfZekr extends StatelessWidget {
  final String title;
  final List<ArrayModel> zekr;
  const DetailsOfZekr({
    super.key,
    required this.zekr,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BuildIconBackWidget(),
        title: Text(title),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Scrollbar(
            child: ListView.builder(
              itemCount: zekr.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  alignment: AlignmentDirectional.center,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1,
                      color: context.read<ThemeCubit>().state
                          ? AppColors.white.withOpacity(0.5)
                          : AppColors.black,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                    children: [
                      BuildAvatarNumber(
                        index: index,
                      ),
                      Text(
                        zekr[index].text,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.textStyleFont16,
                      ),
                      Chip(
                        label: Text(
                          '${AppLocalizations.of(context)!.howOfen} : ${zekr[index].count}',
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: context.read<ThemeCubit>().state
                            ? AppColors.white.withOpacity(0.5)
                            : AppColors.red.withOpacity(0.5),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
