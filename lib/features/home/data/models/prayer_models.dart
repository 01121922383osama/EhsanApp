import '../../domain/entities/prayer_time_entity.dart';

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
    final now = DateTime.now();
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  String formatTime(DateTime time) {
    return "${time.hour % 12}:${time.minute == 0 ? '00' : time.minute} ${time.hour < 12 ? 'AM' : 'PM'}";
  }
}
