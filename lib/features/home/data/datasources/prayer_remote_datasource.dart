import 'package:intl/intl.dart';

import '../../../../core/api/api_consumer.dart';
import '../models/prayer_models.dart';

abstract class PrayerRemoteDataSource {
  Future<PrayerTimeModel> getPrayerTime();
}

class PrayerRemoteDataSourceImpl implements PrayerRemoteDataSource {
  final ApiConsumerService apiConsumerService;

  PrayerRemoteDataSourceImpl({required this.apiConsumerService});
  @override
  Future<PrayerTimeModel> getPrayerTime() async {
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('dd-MM-yyyy').format(currentDate);
    final response = await apiConsumerService.get(
        url:
            'http://api.aladhan.com/v1/timingsByAddress/$formattedDate?address=cairo');
    return PrayerTimeModel.fromJson(response);
  }
}
