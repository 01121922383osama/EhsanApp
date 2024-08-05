import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/extension/blurry_widget.dart';
import '../../../../../core/widgets/build_leading_widget.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/animation_colors.dart';
import 'cubit/asmaa_hosna_cubit.dart';

class AsmaaAllahPage extends StatelessWidget {
  const AsmaaAllahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationColorsContainer(
        child: SafeArea(
          top: false,
          child: Stack(
            children: [
              BlocBuilder<AsmaaHosnaCubit, AsmaaHosnaState>(
                builder: (context, state) {
                  if (state is AsmaaHosnaLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (state is AsmaaHosnaSuccess) {
                    return SafeArea(
                      child: Scrollbar(
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification: (notification) {
                            notification.disallowIndicator();
                            return true;
                          },
                          child: ListView.builder(
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
                        ),
                      ),
                    );
                  }
                  if (state is AsmaaHosnaFialure) {
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
              ),
              const Padding(
                padding: EdgeInsetsDirectional.only(top: 20),
                child: BuildIconBackWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsAmaaHosna extends StatelessWidget {
  final int index;
  final String name;
  final String text;
  const DetailsAmaaHosna({
    super.key,
    required this.index,
    required this.name,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: AlignmentDirectional.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Chip(
            label: Text(
              name,
              style: AppTextStyles.textStyleFont20.copyWith(
                color: AppColors.white,
              ),
            ),
            color: WidgetStatePropertyAll(AppColors.red.withOpacity(0.5)),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(width: 0.8),
            ),
            color: AppColors.white.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: AppTextStyles.textStyleFont15WoColor.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ).blurry(blur: 15),
    );
  }
}
