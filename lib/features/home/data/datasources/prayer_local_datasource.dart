import 'package:hive/hive.dart';

import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/prayer_time_entity.dart';

abstract class PrayerTimeLocalDataSource {
  PrayerTimeEntity? getPrayerTime();
}

class PrayerTimeLocalDataSourceImpl implements PrayerTimeLocalDataSource {
  @override
  PrayerTimeEntity? getPrayerTime() {
    final box = Hive.box<PrayerTimeEntity>(AppString.keyPrayerTime)
        .get(AppString.keyPrayerTime);
    return box;
  }
}
