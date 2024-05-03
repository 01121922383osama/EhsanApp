import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'list_of_sabeh_state.dart';

class ListOfSabehCubit extends Cubit<ListOfSabehState> {
  ListOfSabehCubit()
      : super(ListOfSabehInitial(listOfSabeh: _list, getValue: _list[0]));
  String chooseString({String? value}) {
    if (value != null) {
      emit(ListOfSabehInitial(listOfSabeh: _list, getValue: value));
      return value;
    } else {
      return _list[0];
    }
  }
}

const List<String> _list = [
  'سبحان الله',
  'الحمد لله',
  'لا اله الا الله',
  'الله اكبر',
  'لا حول ولا قوة الا بالله',
];
