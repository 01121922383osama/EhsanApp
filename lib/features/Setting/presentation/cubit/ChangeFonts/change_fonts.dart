import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_lancer/core/utils/app_strings.dart';
import 'package:hive_flutter/adapters.dart';

class ChangeFonts extends Cubit<double> {
  ChangeFonts()
      : super(Hive.box(AppString.changeFonts)
            .get(AppString.changeFonts, defaultValue: 18.0));
  void changeFont(double newFont) {
    Hive.box(AppString.changeFonts).put(AppString.changeFonts, newFont);
    emit(newFont);
  }
}
