import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/prayer_time_usecases.dart';

part 'get_next_prayer_time_state.dart';

class GetNextPrayerTimeCubit extends Cubit<GetNextPrayerTimeState> {
  final PrayerTimeUseCases _prayerTimeUseCases;
  GetNextPrayerTimeCubit({required PrayerTimeUseCases prayerTimeUseCases})
      : _prayerTimeUseCases = prayerTimeUseCases,
        super(GetNextPrayerTimeInitial());

  /// get next prayerTime [Duration] ///

  Stream<DateTime> getNextPrayerTime() async* {
    emit(GetNextPrayerTimeLoading());
    final result = await _prayerTimeUseCases.getPrayerTime();
    yield* Stream.periodic(
      const Duration(seconds: 1),
      (t) {
        DateTime dateTime = DateTime.now();
        final List<DateTime> time = [
          result!.fajr,
          result.sunrise,
          result.dhuhr,
          result.asr,
          result.maghrib,
          result.isha,
        ];
        for (var i = 0; i < time.length; i++) {
          for (var date in time) {
            if (date == time[i]) {
              dateTime = date;
              emit(GetNextPrayerTimeSuccess(time: date));
            }
          }
        }
        return dateTime;
      },
    );
  }
}
