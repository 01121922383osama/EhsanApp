import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_lancer/core/utils/app_strings.dart';
import 'package:free_lancer/features/home/presentation/pages/Hadith/models/zekr_model.dart';

part 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit() : super(AzkarInitial());

  void getZekrData() async {
    try {
      emit(const AzkarLoading());
      final jsonString = await rootBundle.loadString(AppString.adhkar);
      final jsonResponse = json.decode(jsonString) as List;
      final azkar =
          jsonResponse.map((zekr) => ZekrModel.fromJson(zekr)).toList();
      emit(AzkarSuccess(azkar: azkar));
    } catch (e) {
      emit(AzkarFailure(error: e.toString()));
      throw Exception('There is no Data');
    }
  }
}
