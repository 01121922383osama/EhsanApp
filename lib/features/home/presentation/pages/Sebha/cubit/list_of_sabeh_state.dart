part of 'list_of_sabeh_cubit.dart';

sealed class ListOfSabehState extends Equatable {
  final List<String> listOfSabeh;
  final String getValue;

  const ListOfSabehState({required this.listOfSabeh, required this.getValue});

  @override
  List<Object> get props => [listOfSabeh, getValue];
}

final class ListOfSabehInitial extends ListOfSabehState {
  const ListOfSabehInitial(
      {required super.listOfSabeh, required super.getValue});

  @override
  List<Object> get props => [listOfSabeh, getValue];
}
