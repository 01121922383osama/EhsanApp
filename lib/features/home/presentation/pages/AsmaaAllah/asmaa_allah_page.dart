import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_appbar.dart';

import '../../../../../core/widgets/build_leading_widget.dart';
import 'cubit/asmaa_hosna_cubit.dart';
import 'models/details_asmaa_allah.dart';

class AsmaaAllahPage extends StatelessWidget {
  const AsmaaAllahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        leading: BuildIconBackWidget(),
      ),
      body: BlocBuilder<AsmaaHosnaCubit, AsmaaHosnaState>(
        builder: (context, state) {
          if (state is AsmaaHosnaLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is AsmaaHosnaSuccess) {
            return NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: ListView.builder(
                cacheExtent: 1000,
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
            return Center(
              child: Text(state.error),
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}
