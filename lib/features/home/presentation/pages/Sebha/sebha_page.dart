import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/extension/extension.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/build_leading_widget.dart';
import 'SebehCubit/sabeh_cubit.dart';
import 'cubit/list_of_sabeh_cubit.dart';
import 'widgets/build_anim_icon.dart';

class SebhaPage extends StatelessWidget {
  const SebhaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SabehCubit()),
        BlocProvider(create: (context) => ListOfSabehCubit()),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            title: const BuildIconBackWidget(),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                height: context.height * 0.5,
                width: context.width,
                decoration: BoxDecoration(
                  color: AppColors.lightgray,
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
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomDropdown<String>(
                            hintText: 'Choose the zikr',
                            items: state.listOfSabeh,
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
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
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
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
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
                  color: AppColors.lightgray,
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimIconWidget(
                      getDouble: (p0) => getDouble1(p0),
                      iconData: Icons.add,
                    ),
                    Positioned(
                      top: context.height * 0.1,
                      right: context.width * 0.1,
                      child: AnimIconWidget(
                        getDouble: (p0) => getDouble2(p0),
                        iconData: Icons.remove,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
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
