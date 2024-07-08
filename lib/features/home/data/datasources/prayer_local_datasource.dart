import 'package:hive/hive.dart';

import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/prayer_time_entity.dart';

abstract class PrayerTimeLocalDataSource {
  Future<List<PrayerTimeEntity>> getPrayerTime();
}

class PrayerTimeLocalDataSourceImpl implements PrayerTimeLocalDataSource {
  @override
  Future<List<PrayerTimeEntity>> getPrayerTime() async {
    final box = Hive.box<PrayerTimeEntity>(AppString.keyPrayerTime);
    return box.values.toList();
  }
}
