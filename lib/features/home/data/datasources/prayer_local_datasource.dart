import 'package:free_lancer/features/home/data/models/prayer_models.dart';

abstract class PrayerTimeLocalDataSource {
  Future<PrayerTimeModel> getPrayerTime();
}

class PrayerTimeLocalDataSourceImpl implements PrayerTimeLocalDataSource {
  @override
  Future<PrayerTimeModel> getPrayerTime() async {
    throw UnimplementedError();
  }
}
