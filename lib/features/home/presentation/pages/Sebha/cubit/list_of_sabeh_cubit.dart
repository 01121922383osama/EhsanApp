import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_lancer/core/constants/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../data/models/custom_zekr_model.dart';

part 'list_of_sabeh_state.dart';

final List<String> _defaultList = [
  'سُبْحَانَ اللَّهِ',
  'الحمد لله',
  'اللّه اكبر',
  'لا اله الا اللَّه',
  'لا حول ولا قوة الا بالله',
  'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ',
  'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
  'سُبْحَانَ اللَّه الْعَظِيمِ وَبِحَمْدِهِ',
];

class ListOfSabehCubit extends Cubit<ListOfSabehState> {
  final Box<CustomZekrModel> _customZekrBox;

  ListOfSabehCubit()
      : _customZekrBox = Hive.box<CustomZekrModel>(AppConstants.customZekrBox),
        super(ListOfSabehInitial(
          listOfTasbeh: _defaultList,
          getValue: _defaultList[0],
        )) {
    _loadCustomZekrs();
  }

  Future<void> addCustomZekr(String customZekr) async {
    await _customZekrBox.add(CustomZekrModel(text: customZekr));
    _loadCustomZekrs();
  }

  void chooseString({String? value}) {
    emit(ListOfSabehInitial(
        listOfTasbeh: state.listOfTasbeh, getValue: value ?? state.getValue));
  }

  Future<void> deleteCustomZekr(int index) async {
    final customIndex = index - _defaultList.length;
    if (customIndex >= 0 && customIndex < _customZekrBox.length) {
      await _customZekrBox.deleteAt(customIndex);
      _loadCustomZekrs();
      final newList = [
        ..._defaultList,
        ..._customZekrBox.values.map((e) => e.text)
      ];
      emit(ListOfSabehInitial(
          listOfTasbeh: newList, getValue: 'سُبْحَانَ اللَّهِ'));
    }
  }

  Future<void> editCustomZekr(int index, String newText) async {
    final customIndex = index - _defaultList.length;
    if (customIndex >= 0 && customIndex < _customZekrBox.length) {
      final zekr = _customZekrBox.getAt(customIndex);
      if (zekr != null) {
        zekr.text = newText;
        await zekr.save();
        final newList = [
          ..._defaultList,
          ..._customZekrBox.values.map((e) => e.text)
        ];
        emit(ListOfSabehInitial(
            listOfTasbeh: newList, getValue: 'سُبْحَانَ اللَّهِ'));
      }
    }
  }

  bool isCustomZekr(int index) {
    return index >= _defaultList.length;
  }

  void _loadCustomZekrs() {
    final customZekrs = _customZekrBox.values.map((e) => e.text).toList();
    final allZekrs = [..._defaultList, ...customZekrs];
    emit(ListOfSabehInitial(
        listOfTasbeh: allZekrs, getValue: 'سُبْحَانَ اللَّهِ'));
  }
}
