import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Error/error.dart';
import '../../domain/entities/surah_entity.dart';
import '../../domain/usecases/get_all_quran_use_cases.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  final GetAllQuranUseCases getAllQuranUseCases;
  QuranCubit({
    required this.getAllQuranUseCases,
  }) : super(QuranInitial());
  Future<void> getSurahs() async {
    final Either<Failure, List<SurahEntity>> surah =
        await getAllQuranUseCases.getAllQuran();
    emit(QuranLoading());
    emit(surah.fold((error) => QuranFailure(message: error.toString()),
        (surah) => QuranSuccess(surah: surah)));
  }
}
