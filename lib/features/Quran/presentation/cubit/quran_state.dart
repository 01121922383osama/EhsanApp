part of 'quran_cubit.dart';

abstract class QuranState extends Equatable {
  const QuranState();

  @override
  List<Object> get props => [];
}

class QuranInitial extends QuranState {}

class QuranLoading extends QuranState {}

class QuranSuccess extends QuranState {
  final List<SurahEntity> surah;

  const QuranSuccess({required this.surah});

  @override
  List<Object> get props => [surah];
}

class QuranFailure extends QuranState {
  final String message;

  const QuranFailure({required this.message});
  @override
  List<Object> get props => [message];
}
