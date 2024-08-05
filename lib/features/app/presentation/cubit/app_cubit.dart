import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppInitial(index: 0));
  final PageController pageController = PageController();

  void changeIndex(int index) {
    emit(AppInitial(index: index));
  }
}
