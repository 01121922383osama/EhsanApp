import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../core/extension/blurry_widget.dart';
import '../../../../../core/widgets/animation_colors.dart';

import '../../../../../core/extension/extension.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/build_leading_widget.dart';
import 'SebehCubit/sabeh_cubit.dart';
import 'cubit/list_of_sabeh_cubit.dart';
import 'widgets/build_anim_icon.dart';

class SebhaPage extends StatelessWidget {
  const SebhaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: const AnimationColorsContainer(
            child: SafeArea(
              child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: BuildIconBackWidget()),
            ),
          ),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: AnimationColorsContainer(
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  height: context.height * 0.5,
                  width: context.width,
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: BlocBuilder<ListOfSabehCubit, ListOfSabehState>(
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 60,
                            margin: const EdgeInsets.all(10),
                            width: context.width,
                            decoration: BoxDecoration(
                              color: AppColors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CustomDropdown<String>(
                              hintText:
                                  AppLocalizations.of(context)!.chooseZekr,
                              items: state.listOfSabeh,
                              decoration: CustomDropdownDecoration(
                                headerStyle: AppTextStyles.textStyleFont0Bold,
                                listItemStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              initialItem: state.listOfSabeh[0],
                              onChanged: (value) {
                                context
                                    .read<ListOfSabehCubit>()
                                    .chooseString(value: value);
                                context.read<SabehCubit>().reset();
                              },
                            ),
                          ).blurry(
                            blur: 1,
                          ),
                          SizedBox(height: context.height * 0.1),
                          Center(
                            child:
                                BlocBuilder<ListOfSabehCubit, ListOfSabehState>(
                              builder: (context, state) {
                                return Text(
                                  state.getValue,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.textStyleFont20.copyWith(
                                    color: AppColors.redDart,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: context.height * 0.1),
                          BlocBuilder<SabehCubit, int>(
                            builder: (context, state) {
                              return Text(
                                '$state',
                                style: AppTextStyles.textStyleFont30.copyWith(
                                  color: AppColors.redDart,
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  height: context.height * 0.3,
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.transparent.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimIconWidget(
                        getDouble: (p0) => getDouble1(p0),
                        iconData: Icons.add,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: AnimIconWidget(
                            getDouble: (p0) => getDouble2(p0),
                            iconData: Icons.remove,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: AnimIconWidget(
                            getDouble: (p0) => getDouble2(p0),
                            iconData: Icons.restart_alt,
                          ),
                        ),
                      ),
                    ],
                  ).blurry(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

double getDouble1(int i) {
  switch (i) {
    case 0:
      return 15;
    case 1:
      return 20;
    case 2:
      return 30;
    case 3:
      return 40;
    case 4:
      return 60;
    default:
      return 50;
  }
}

double getDouble2(int i) {
  switch (i) {
    case 0:
      return 5;
    case 1:
      return 10;
    case 2:
      return 15;
    case 3:
      return 20;
    case 4:
      return 25;
    default:
      return 15;
  }
}
