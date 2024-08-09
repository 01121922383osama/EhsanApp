import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/extension/extension.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/build_leading_widget.dart';
import '../../../../Quran/presentation/widgets/build_avatar_surah.dart';
import '../../../../Setting/presentation/cubit/Theme/theme_cubit.dart';
import '../../widgets/details_of_zek.dart';
import 'cubit/azkar_cubit.dart';
import 'models/zekr_model.dart';

class ZekrSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: IconButton(
          onPressed: () {
            if (query.isNotEmpty) {
              query = '';
            } else {
              close(context, false);
            }
          },
          icon: const Icon(Icons.close),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BuildIconBackWidget();
  }

  @override
  Widget buildResults(BuildContext context) {
    List<ZekrModel> resilts = [];
    return BlocBuilder<AzkarCubit, AzkarState>(
      builder: (context, state) {
        if (state is AzkarSuccess) {
          for (var zekr in state.azkar) {
            if (zekr.category.toLowerCase().contains(query.toLowerCase())) {
              resilts.add(zekr);
            }
          }
          return ListView.builder(
            itemCount: resilts.length,
            itemBuilder: (context, index) {
              final zekr = resilts[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    // side: BorderSide(
                    //   color: context.read<ThemeCubit>().state
                    //       ?
                    //       :
                    // ),
                  ),
                  leading: BuildAvatarNumber(index: index),
                  title: Text(zekr.category),
                  onTap: () {
                    context.push(
                      widget: DetailsOfZekr(
                        title: zekr.category,
                        zekr: zekr.array,
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ZekrModel> sugestions = [];
    return BlocBuilder<AzkarCubit, AzkarState>(
      builder: (context, state) {
        if (state is AzkarSuccess) {
          for (var zekr in state.azkar) {
            if (zekr.category.toLowerCase().contains(query.toLowerCase())) {
              sugestions.add(zekr);
            }
          }
          return ListView.builder(
            itemCount: sugestions.length,
            itemBuilder: (context, index) {
              final zekr = sugestions[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    // side: BorderSide(
                    //   color: context.read<ThemeCubit>().state
                    //       ?
                    //       :
                    // ),
                  ),
                  leading: BuildAvatarNumber(
                    index: index,
                  ),
                  title: Text(zekr.category),
                  onTap: () {
                    context.push(
                      widget: DetailsOfZekr(
                        title: zekr.category,
                        zekr: zekr.array,
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}
