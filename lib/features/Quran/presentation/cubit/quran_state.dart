part of 'quran_cubit.dart';

abstract class QuranState extends Equatable {
  const QuranState();

  @override
  List<Object> get props => [];
}

class QuranInitial extends QuranState {
  const QuranInitial();
  @override
  List<Object> get props => [];
}

class QuranLoading extends QuranState {}

class QuranSuccess extends QuranState {
  const QuranSuccess();

  @override
  List<Object> get props => [];
}

class QuranFailure extends QuranState {
  final String message;

  const QuranFailure({required this.message});
  @override
  List<Object> get props => [message];
}
