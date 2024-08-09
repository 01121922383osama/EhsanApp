import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_lancer/features/Setting/presentation/cubit/Theme/theme_cubit.dart';

import '../../../../core/extension/extension.dart';
import '../../../../core/widgets/build_leading_widget.dart';
import '../../../Quran/presentation/widgets/leading_widget.dart';
import '../../data/datasources/LocalDataSourceShaikh/export.dart';
import '../../data/models/models_urls.dart';
import '../pages/build_audio_page.dart';

class BuildMenuShai5 extends StatelessWidget {
  const BuildMenuShai5({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: _list.length,
      itemBuilder: (context, index) {
        return Scrollbar(
          child: Card(
            color: context.read<ThemeCubit>().state
                ? Colors.transparent
                : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onTap: () {
                context.push(
                  widget: BuildAudioPage(
                    audioUrl: _list[index],
                  ),
                );
              },
              leading: LeadingWidget(index: index),
              title: Text(
                _list[index][index].title1,
              ),
            ),
          ),
        );
      },
    );
  }
}

List<List<Urls>> _list = [
  file1_1,
  file1_2,
  file1_3,
  file1_8,
  file1_9,
  file1_10,
  file1_11,
  file1_16,
  file1_17,
  file1_18,
  file1_19,
  file1_20,
  file1_21,
  file1_22,
  file1_23,
  file1_24,
  file1_25,
  file2_1,
  file2_2,
  file2_3,
  file2_4,
  file2_5,
  file2_6,
  file2_7,
  file2_8,
  file2_10,
  file2_11,
  file2_12,
  file2_13,
  file2_14,
  file2_15,
  file2_16,
  file2_17,
  file2_18,
  file2_19,
  file2_20,
  file2_21,
  file2_22,
  file2_23,
  file2_24,
  file3_4,
  file3_5,
  file3_6,
  file3_7,
  file3_8,
  file3_9,
  file3_12,
  file3_13,
  file3_14,
  file3_15,
  file3_16,
  file3_17,
  file3_18,
  file3_19,
  file3_20,
  file3_21,
  file3_22,
  file3_23,
  file3_24,
  file3_25,
  file4_1,
  file4_2,
  file4_3,
  file4_4,
  file4_5,
  file4_6,
  file4_7,
  file4_8,
  file4_10,
  file4_11,
  file4_12,
  file4_13,
  file4_14,
  file4_15,
  file4_16,
  file4_17,
  file4_18,
  file4_19,
  file4_20,
  file4_21,
  file4_22,
  file4_23,
  file4_24,
  file5_1,
  file5_2,
  file5_3,
  file5_6,
  file5_7,
  file5_8,
  file5_9,
  file5_16,
  file5_17,
  file5_20,
  file5_21,
  file6_4,
  file6_5,
  file6_6,
  file6_7,
  file6_8,
  file6_10,
  file6_11,
  file6_12,
];

class SearchMoshaf extends SearchDelegate {
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
    List<List<Urls>> result = [];
    for (var i = 0; i < _list.length; i++) {
      for (var j = 0; j < _list[i].length; j++) {
        if (_list[i][j].title1.toLowerCase().contains(query.toLowerCase())) {
          result.add(_list[i]);
          break;
        }
      }
    }
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 0.3,
        );
      },
      itemCount: result.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            context.pushReplacement(
              widget: BuildAudioPage(
                audioUrl: result[index],
              ),
            );
          },
          leading: LeadingWidget(index: index),
          title: Text(result[index][0].title1),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<List<Urls>> suggestions = [];
    for (var i = 0; i < _list.length; i++) {
      for (var j = 0; j < _list[i].length; j++) {
        if (_list[i][j].title1.toLowerCase().contains(query.toLowerCase())) {
          suggestions.add(_list[i]);
          break;
        }
      }
    }
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 0.3,
        );
      },
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            context.pushReplacement(
              widget: BuildAudioPage(
                audioUrl: suggestions[index],
              ),
            );
          },
          leading: LeadingWidget(index: index),
          title: Text(suggestions[index][0].title1),
        );
      },
    );
  }
}
