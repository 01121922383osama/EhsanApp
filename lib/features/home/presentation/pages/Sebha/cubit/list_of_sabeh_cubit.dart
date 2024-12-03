import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'list_of_sabeh_state.dart';

class ListOfSabehCubit extends Cubit<ListOfSabehState> {
  ListOfSabehCubit()
      : super(ListOfSabehInitial(listOfTasbeh: _list, getValue: _list[0]));
  void chooseString({String? value}) {
    emit(ListOfSabehInitial(listOfTasbeh: _list, getValue: value ?? _list[0]));
  }
}

List<String> _list = [
  'سُبْحَانَ اللَّهِ',
  'الحمد لله',
  'اللّه اكبر',
  'لا اله الا اللَّه',
  'لا حول ولا قوة الا بالله',
  'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ',
  'سُبْحَانَ اللَّه وَبِحَمْدِهِ',
  'سُبْحَانَ اللَّه الْعَظِيمِ وَبِحَمْدِهِ',
];
