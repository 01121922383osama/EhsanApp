import 'package:free_lancer/core/api/api_consumer.dart';
import 'package:free_lancer/features/home/data/models/prayer_models.dart';

abstract class PrayerRemoteDataSource {
  Future<PrayerTimeModel> getPrayerTime();
}

class PrayerRemoteDataSourceImpl implements PrayerRemoteDataSource {
  final ApiConsumerService apiConsumerService;

  PrayerRemoteDataSourceImpl({required this.apiConsumerService});
  @override
  Future<PrayerTimeModel> getPrayerTime() async {
    final response = await apiConsumerService.get(
        url:
            'https://api.aladhan.com/v1/timingsByAddress/05-03-2024?address=cairo');
    return PrayerTimeModel.fromJson(response);
  }
}
