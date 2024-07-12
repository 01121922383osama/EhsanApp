import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../models/asmaa_hosna.dart';

part 'asmaa_hosna_state.dart';

class AsmaaHosnaCubit extends Cubit<AsmaaHosnaState> {
  AsmaaHosnaCubit() : super(const AsmaaHosnaInitial());
  void getData() async {
    try {
      emit(const AsmaaHosnaLoading());
      final jsonString = await rootBundle.loadString(AppString.asmaHosna);
      final jsonResponse = json.decode(jsonString) as List;
      final asmaaHosna = jsonResponse
          .map((asmaaAlahHosnaa) => AsmaaHosnaModel.fromJson(asmaaAlahHosnaa))
          .toList();
      emit(AsmaaHosnaSuccess(asmaaModel: asmaaHosna));
    } catch (e) {
      emit(AsmaaHosnaFialure(error: e.toString()));
    }
  }
}
