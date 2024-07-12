part of 'asmaa_hosna_cubit.dart';

sealed class AsmaaHosnaState extends Equatable {
  const AsmaaHosnaState();

  @override
  List<Object> get props => [];
}

final class AsmaaHosnaInitial extends AsmaaHosnaState {
  const AsmaaHosnaInitial();
}

final class AsmaaHosnaLoading extends AsmaaHosnaState {
  const AsmaaHosnaLoading();
}

final class AsmaaHosnaSuccess extends AsmaaHosnaState {
  final List<AsmaaHosnaModel> asmaaModel;

  const AsmaaHosnaSuccess({required this.asmaaModel});
  @override
  List<Object> get props => [asmaaModel];
}

final class AsmaaHosnaFialure extends AsmaaHosnaState {
  final String error;
  const AsmaaHosnaFialure({required this.error});

  @override
  List<Object> get props => [error];
}
