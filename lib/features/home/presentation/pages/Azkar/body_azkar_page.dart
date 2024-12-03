import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Setting/presentation/cubit/Theme/theme_cubit.dart';

import '../../../../../../core/extension/extension.dart';
import '../../../../Quran/presentation/widgets/build_avatar_surah.dart';
import 'cubit/azkar_cubit.dart';
import 'details_of_zek.dart';

class BodyAzkarPage extends StatelessWidget {
  const BodyAzkarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AzkarCubit, AzkarState>(
      builder: (context, state) {
        if (state is AzkarSuccess) {
          final azkar = state.azkar;
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            cacheExtent: 1000,
            itemCount: azkar.length,
            itemBuilder: (context, index) {
              final zekr = azkar[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(),
                ),
                color: context.read<ThemeCubit>().state
                    ? Colors.transparent
                    : Colors.white,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
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
