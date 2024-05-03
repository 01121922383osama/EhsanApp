import 'dart:isolate';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_lancer/features/home/domain/entities/prayer_time_entity.dart';
import 'package:free_lancer/features/home/domain/usecases/prayer_time_usecases.dart';

part 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  final PrayerTimeUseCases prayerTimeUseCases;
  PrayerCubit({required this.prayerTimeUseCases}) : super(PrayerInitial());

  Future<void> getPrayerTime() async {
    emit(PrayerLoading());
    final result = await Isolate.run(() {
      return prayerTimeUseCases.getPrayerTime();
    });
    emit(PrayerSuccess(prayerTime: result));
  }
}
