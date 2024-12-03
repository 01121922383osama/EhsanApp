part of 'list_of_sabeh_cubit.dart';

abstract class ListOfSabehState extends Equatable {
  final List<String> listOfTasbeh;
  final String getValue;

  const ListOfSabehState({required this.listOfTasbeh, required this.getValue});

  @override
  List<Object> get props => [listOfTasbeh, getValue];
}

class ListOfSabehInitial extends ListOfSabehState {
  const ListOfSabehInitial(
      {required super.listOfTasbeh, required super.getValue});
}
