import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/extension/extension.dart';
import '../../widgets/home_feature_ui.dart';
import 'cubit/azkar_cubit.dart';
import 'details_of_zek.dart';
import 'models/zekr_model.dart';

class ZekrSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        border: InputBorder.none,
        hintStyle: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.outline,
        ),
      ),
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
  Widget buildResults(BuildContext context) {
    return BlocBuilder<AzkarCubit, AzkarState>(
      builder: (context, state) {
        if (state is AzkarSuccess) {
          return _buildList(context, _filter(state.azkar));
        }
        return HomeFeatureUi.compactLoading();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<AzkarCubit, AzkarState>(
      builder: (context, state) {
        if (state is AzkarSuccess) {
          return _buildList(context, _filter(state.azkar));
        }
        return HomeFeatureUi.compactLoading();
      },
    );
  }

  Widget _buildList(BuildContext context, List<ZekrModel> results) {
    if (results.isEmpty) {
      return HomeFeatureUi.emptyState(context, 'لا توجد نتائج');
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: HomeFeatureUi.pagePadding,
      itemCount: results.length,
      itemBuilder: (context, index) {
        final zekr = results[index];
        return HomeFeatureUi.categoryTile(
          context: context,
          index: index,
          title: zekr.category,
          onTap: () {
            close(context, zekr.category);
            context.push(
              widget: DetailsOfZekr(
                title: zekr.category,
                zekr: zekr.array,
              ),
            );
          },
        ).animate(delay: (25 * index).ms).fadeIn(duration: 50.ms);
      },
    );
  }

  List<ZekrModel> _filter(List<ZekrModel> azkar) {
    if (query.trim().isEmpty) return azkar;
    final q = query.toLowerCase();
    return azkar
        .where((zekr) => zekr.category.toLowerCase().contains(q))
        .toList();
  }
}
