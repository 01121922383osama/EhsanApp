part of 'prayer_cubit.dart';

sealed class PrayerState extends Equatable {
  const PrayerState();

  @override
  List<Object> get props => [];
}

final class PrayerInitial extends PrayerState {}

final class PrayerLoading extends PrayerState {}

final class PrayerSuccess extends PrayerState {
  final PrayerTimeEntity prayerTime;

  const PrayerSuccess({required this.prayerTime});
}
