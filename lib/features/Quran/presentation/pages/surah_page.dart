import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/extension/extension.dart';
import '../../../../core/widgets/build_leading_widget.dart';
import '../../../../core/widgets/space_widget.dart';
import '../../../Setting/presentation/cubit/ChangeFonts/change_fonts.dart';
import '../../../Setting/presentation/cubit/Theme/theme_cubit.dart';
import '../widgets/details_surah.dart';

class SurahPage extends StatelessWidget {
  final String? suraName;
  final int? indexOfSurah;
  const SurahPage({super.key, this.suraName, this.indexOfSurah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            leading: const Padding(
              padding: EdgeInsets.all(4),
              child: BuildIconBackWidget(),
            ),
            title: Text(suraName!),
            centerTitle: true,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(8),
              ),
            ),
            actions: [
              BuildIconBackWidget(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog.adaptive(
                        title: Text(AppLocalizations.of(context)!.fontsize),
                        content: BlocBuilder<ChangeFonts, double>(
                          builder: (context, state) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    const Text('18'),
                                    Expanded(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Slider.adaptive(
                                          value: state,
                                          min: 18.0,
                                          max: 40.0,
                                          divisions: 12,
                                          onChanged: (value) {
                                            context
                                                .read<ChangeFonts>()
                                                .changeFont(value);
                                          },
                                        ),
                                      ),
                                    ),
                                    Text(state.floor().toString()),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  AppLocalizations.of(context)!.holyQuran,
                                  style: TextStyle(
                                    fontSize: state,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        actionsAlignment: MainAxisAlignment.start,
                        actions: [
                          ElevatedButton(
                            onPressed: () => context.pop(),
                            child: Text(AppLocalizations.of(context)!.yes),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.font_download_rounded),
              )
            ],
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
                          ? Colors.white
                          : Colors.black,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          DetailsSurahWidget(
            indexOfSurah: indexOfSurah,
          ),
        ],
      ),
    );
  }
}
