import 'package:free_lancer/features/home/domain/entities/prayer_time_entity.dart';

abstract class PrayerTimeRepo {
  Future<PrayerTimeEntity> getPrayerTime();
}
