import '../entities/prayer_time_entity.dart';

abstract class PrayerTimeRepo {
  Future<PrayerTimeEntity> getPrayerTime();
}
