part of 'list_of_sabeh_cubit.dart';

abstract class ListOfSabehState extends Equatable {
  final List<String> listOfSabeh;
  final String getValue;

  const ListOfSabehState({required this.listOfSabeh, required this.getValue});

  @override
  List<Object> get props => [listOfSabeh, getValue];
}

class ListOfSabehInitial extends ListOfSabehState {
  const ListOfSabehInitial(
      {required super.listOfSabeh, required super.getValue});
}
