import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_durations.dart';
import '../../../home/presentation/widgets/home_feature_ui.dart';
import '../../data/datasources/LocalDataSourceShaikh/export.dart';
import '../../data/datasources/LocalDataSourceShaikh/urls_file1_12.dart';
import '../../data/datasources/LocalDataSourceShaikh/urls_file1_13.dart';
import '../../data/datasources/LocalDataSourceShaikh/urls_file1_14.dart';
import '../../data/datasources/LocalDataSourceShaikh/urls_file1_15.dart';
import '../../data/datasources/LocalDataSourceShaikh/urls_file2_9.dart';
import '../../data/datasources/LocalDataSourceShaikh/urls_file3_10.dart';
import '../../data/datasources/LocalDataSourceShaikh/urls_file3_11.dart';
import '../../data/datasources/LocalDataSourceShaikh/urls_file4_9.dart';
import '../../data/datasources/LocalDataSourceShaikh/urls_file5_12.dart';
import '../../data/datasources/LocalDataSourceShaikh/urls_file5_13.dart';
import '../../data/datasources/LocalDataSourceShaikh/urls_file5_18.dart';
import '../../data/models/models_urls.dart';
import '../pages/build_audio_page.dart';

class BuildMenuShai5 extends StatelessWidget {
  const BuildMenuShai5({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: HomeFeatureUi.pagePadding.copyWith(top: 0),
      sliver: SliverList.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          final reciter = _list[index];
          if (reciter.isEmpty) return const SizedBox.shrink();

          return HomeFeatureUi.categoryTile(
            context: context,
            index: index,
            title: reciter.first.title1,
            onTap: () {
              context.push(
                widget: BuildAudioPage(audioUrl: reciter),
              );
            },
          )
              .animate(delay: (20 * (index % 8)).ms)
              .fadeIn(duration: AppDurations.animation);
        },
      ),
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
  file1_12,
  file1_13,
  file1_14,
  file1_15,
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
  file2_9,
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
  file3_10,
  file3_11,
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
  file4_9,
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
  file5_12,
  file5_13,
  file5_16,
  file5_17,
  file5_18,
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
  List<List<Urls>> _filter() {
    if (query.trim().isEmpty) return _list;
    final q = query.toLowerCase();
    final results = <List<Urls>>[];
    for (final reciter in _list) {
      if (reciter.isEmpty) continue;
      if (reciter.first.title1.toLowerCase().contains(q)) {
        results.add(reciter);
      }
    }
    return results;
  }

  Widget _buildList(BuildContext context, List<List<Urls>> items) {
    if (items.isEmpty) {
      return HomeFeatureUi.emptyState(context, 'لا توجد نتائج');
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: HomeFeatureUi.pagePadding,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final reciter = items[index];
        return HomeFeatureUi.categoryTile(
          context: context,
          index: index,
          title: reciter.first.title1,
          onTap: () {
            close(context, reciter.first.title1);
            context.pushReplacement(
              widget: BuildAudioPage(audioUrl: reciter),
            );
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isNotEmpty) {
            query = '';
            showSuggestions(context);
          } else {
            close(context, false);
          }
        },
        icon: const Icon(Icons.close_rounded, size: 22),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, false),
      icon: const Icon(Icons.arrow_back_rounded, size: 22),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildList(context, _filter());

  @override
  Widget buildSuggestions(BuildContext context) => _buildList(context, _filter());
}
