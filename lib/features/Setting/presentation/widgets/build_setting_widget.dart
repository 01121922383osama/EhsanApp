import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/Theme/theme_cubit.dart';

class BuildSettingsWidget extends StatelessWidget {
  final List<Widget> widgets;
  const BuildSettingsWidget({super.key, required this.widgets});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, state) {
          return Card(
            color: context.read<ThemeCubit>().state
                ? Colors.transparent
                : Colors.white,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widgets.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return widgets[index];
              },
            ),
          );
        },
      ),
    );
  }
}
