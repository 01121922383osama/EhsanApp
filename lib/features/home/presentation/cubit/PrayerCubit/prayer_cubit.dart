import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/prayer_time_entity.dart';
import '../../../domain/usecases/prayer_time_usecases.dart';

part 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  final PrayerTimeUseCases _prayerTimeUseCases;
  PrayerCubit({required PrayerTimeUseCases prayerTimeUseCases})
      : _prayerTimeUseCases = prayerTimeUseCases,
        super(PrayerInitial());

  Future<void> getPrayerTime() async {
    try {
      emit(PrayerLoading());
      final result = await _prayerTimeUseCases.getPrayerTime();
      emit(PrayerSuccess(prayerTime: result!));
    } catch (e) {
      emit(PrayerFailure(messageError: e.toString()));
    }
  }
}
