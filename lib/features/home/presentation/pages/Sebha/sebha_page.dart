import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/extension/extension.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/build_leading_widget.dart';
import '../../../../../core/widgets/custom_appbar.dart';
import 'SebehCubit/sabeh_cubit.dart';
import 'cubit/list_of_sabeh_cubit.dart';
import 'widgets/build_anim_icon.dart';

class SebhaPage extends StatelessWidget {
  const SebhaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: const CustomAppbar(
          leading: BuildIconBackWidget(),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                height: context.height * 0.5,
                width: context.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(),
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
                          child: CustomDropdown<String>(
                            headerBuilder: (context, selectedItem, enabled) {
                              return Text(
                                selectedItem,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              );
                            },
                            hintText: AppLocalizations.of(context)!.chooseZekr,
                            items: state.listOfSabeh,
                            decoration: CustomDropdownDecoration(
                              headerStyle: AppTextStyles.textStyleFont0Bold,
                              listItemStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
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
                        ),
                        SizedBox(height: context.height * 0.1),
                        Center(
                          child:
                              BlocBuilder<ListOfSabehCubit, ListOfSabehState>(
                            builder: (context, state) {
                              return Text(
                                state.getValue,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.textStyleFont20,
                              );
                            },
                          ),
                        ),
                        SizedBox(height: context.height * 0.1),
                        BlocBuilder<SabehCubit, int>(
                          builder: (context, state) {
                            return Text(
                              '$state',
                              style: AppTextStyles.textStyleFont30,
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
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(),
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
                ),
              ),
            ],
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
