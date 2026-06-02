import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/build_leading_widget.dart';
import '../../../../../core/widgets/custom_appbar.dart';
import '../../widgets/home_feature_ui.dart';
import 'cubit/asmaa_hosna_cubit.dart';
import 'models/details_asmaa_allah.dart';

class AsmaaAllahPage extends StatelessWidget {
  const AsmaaAllahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        leading: const BuildIconBackWidget(),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.asmaaAllahTitle,
          style: AppTextStyles.textStyleFont20.copyWith(fontSize: 17),
        ),
      ),
      body: BlocBuilder<AsmaaHosnaCubit, AsmaaHosnaState>(
        builder: (context, state) {
          if (state is AsmaaHosnaLoading) {
            return HomeFeatureUi.compactLoading();
          }
          if (state is AsmaaHosnaSuccess) {
            return NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: HomeFeatureUi.pagePadding,
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
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  state.error,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
              ),
            );
          }
          return HomeFeatureUi.compactLoading();
        },
      ),
    );
  }
}
