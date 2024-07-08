part of 'azkar_cubit.dart';

sealed class AzkarState extends Equatable {
  const AzkarState();

  @override
  List<Object> get props => [];
}

final class AzkarInitial extends AzkarState {}

final class AzkarLoading extends AzkarState {
  const AzkarLoading();
}

final class AzkarSuccess extends AzkarState {
  final List<ZekrModel> azkar;
  const AzkarSuccess({required this.azkar});
}

final class AzkarFailure extends AzkarState {
  final String error;
  const AzkarFailure({required this.error});
}
