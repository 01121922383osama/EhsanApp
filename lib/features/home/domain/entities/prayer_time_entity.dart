import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'prayer_time_entity.g.dart';

@HiveType(typeId: 0)
class PrayerTimeEntity extends Equatable {
  @HiveField(0)
  final DateTime fajr;
  @HiveField(1)
  final DateTime sunrise;
  @HiveField(2)
  final DateTime dhuhr;
  @HiveField(3)
  final DateTime asr;
  @HiveField(4)
  final DateTime maghrib;
  @HiveField(5)
  final DateTime isha;

  const PrayerTimeEntity({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  @override
  List<Object?> get props => [fajr, sunrise, dhuhr, asr, maghrib, isha];
}
