import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../../core/utils/app_strings.dart';

part 'change_language_state.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  ChangeLanguageCubit()
      : super(
          ChangeLanguageInitial(
            lang: Hive.box(AppString.changeLang)
                .get(AppString.changeLang, defaultValue: 'ar'),
          ),
        );
  void changeLang({required String lang}) {
    final newLang = lang;
    Hive.box(AppString.changeLang).put(AppString.changeLang, newLang);
    emit(ChangeLanguageInitial(lang: newLang));
  }
}
