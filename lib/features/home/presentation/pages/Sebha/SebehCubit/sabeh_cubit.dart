import 'package:flutter_bloc/flutter_bloc.dart';

class SabehCubit extends Cubit<int> {
  SabehCubit() : super(0);
  void increment() => emit(state + 1);
  void decrement() {
    if (state > 0) {
      emit(state - 1);
    }
  }

  void reset() => emit(0);
}
