import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_styles.dart';
import '../cubit/GetNextPrayerTime/get_next_prayer_time_cubit.dart';

class GetNextPrayerTime extends StatelessWidget {
  const GetNextPrayerTime({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNextPrayerTimeCubit, GetNextPrayerTimeState>(
      builder: (context, state) {
        if (state is GetNextPrayerTimeSuccess) {
          return SliverToBoxAdapter(
            child: StreamBuilder(
              stream:
                  context.read<GetNextPrayerTimeCubit>().getNextPrayerTime(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '  ${snapshot.data}',
                    style: AppTextStyles.textStyleFont16,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          );
        }
        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      },
    );
  }
}
