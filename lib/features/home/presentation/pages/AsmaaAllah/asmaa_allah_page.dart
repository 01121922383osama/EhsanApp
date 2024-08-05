import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_lancer/core/widgets/build_leading_widget.dart';
import 'package:free_lancer/features/home/presentation/pages/AsmaaAllah/models/details_asmaa_allah.dart';

import '../../../../../core/widgets/animation_colors.dart';
import 'cubit/asmaa_hosna_cubit.dart';

class AsmaaAllahPage extends StatelessWidget {
  const AsmaaAllahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationColorsContainer(
        child: SafeArea(
          child: CustomScrollView(
            cacheExtent: 1000,
            slivers: [
              const SliverAppBar(
                automaticallyImplyLeading: false,
                floating: true,
                flexibleSpace: AnimationColorsContainer(
                  child: Row(
                    children: [
                      BuildIconBackWidget(),
                    ],
                  ),
                ),
              ),
              BlocBuilder<AsmaaHosnaCubit, AsmaaHosnaState>(
                builder: (context, state) {
                  if (state is AsmaaHosnaLoading) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    );
                  }
                  if (state is AsmaaHosnaSuccess) {
                    return NotificationListener<
                        OverscrollIndicatorNotification>(
                      onNotification: (notification) {
                        notification.disallowIndicator();
                        return true;
                      },
                      child: SliverList.builder(
                        itemCount: state.asmaaModel.length,
                        itemBuilder: (context, index) {
                          final asmaAllah = state.asmaaModel[index];
                          return DetailsAmaaHosna(
                            index: index,
                            name: asmaAllah.name,
                            text: asmaAllah.text,
                          );
                        },
                      ),
                    );
                  }
                  if (state is AsmaaHosnaFialure) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(state.error),
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
