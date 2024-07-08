import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../../core/utils/app_strings.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit()
      : super(Hive.box(AppString.themeMode).get(
          AppString.themeMode,
          defaultValue: false,
        ));
  void changeTheme() {
    final newTheme = !state;
    Hive.box(AppString.themeMode).put(AppString.themeMode, newTheme);
    emit(newTheme);
  }
}
