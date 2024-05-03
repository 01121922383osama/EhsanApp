part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  final int index;

  const AppState({required this.index});

  @override
  List<Object> get props => [index];
}

class AppInitial extends AppState {
  const AppInitial({required super.index});

  @override
  List<Object> get props => [index];
}
