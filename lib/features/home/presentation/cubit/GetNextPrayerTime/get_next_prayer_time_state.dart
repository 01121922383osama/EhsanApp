part of 'get_next_prayer_time_cubit.dart';

sealed class GetNextPrayerTimeState extends Equatable {
  const GetNextPrayerTimeState();

  @override
  List<Object> get props => [];
}

final class GetNextPrayerTimeInitial extends GetNextPrayerTimeState {}

final class GetNextPrayerTimeLoading extends GetNextPrayerTimeState {}

final class GetNextPrayerTimeSuccess extends GetNextPrayerTimeState {
  final DateTime time;

  const GetNextPrayerTimeSuccess({required this.time});
}

final class GetNextPrayerTimeFailure extends GetNextPrayerTimeState {
  final String errMessage;

  const GetNextPrayerTimeFailure({required this.errMessage});
}
