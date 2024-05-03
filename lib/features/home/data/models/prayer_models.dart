import 'package:free_lancer/features/home/domain/entities/prayer_time_entity.dart';

class PrayerTimeModel extends PrayerTimeEntity {
  const PrayerTimeModel({
    required super.fajr,
    required super.sunrise,
    required super.dhuhr,
    required super.asr,
    required super.maghrib,
    required super.isha,
  });
  factory PrayerTimeModel.fromJson(Map<String, dynamic> json) {
    return PrayerTimeModel(
      fajr: parseTime(json['Fajr']),
      sunrise: parseTime(json['Sunrise']),
      dhuhr: parseTime(json['Dhuhr']),
      asr: parseTime(json['Asr']),
      maghrib: parseTime(json['Maghrib']),
      isha: parseTime(json['Isha']),
    );
  }
  static DateTime parseTime(String timeString) {
    final List<String> parts = timeString.split(':');
    final int hour = int.parse(parts[0]);
    final int minute = int.parse(parts[1]);
    return DateTime(2024, 1, 1, hour, minute);
  }

  String formatTime(DateTime time) {
    return "${time.hour % 12}:${time.minute == 0 ? '00' : time.minute} ${time.hour < 12 ? 'AM' : 'PM'}";
  }
}
