import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppInitial(index: 0));

  void changeIndex(int index) {
    emit(AppInitial(index: index));
  }
}
