import 'package:geolocator/geolocator.dart';

import '../../../../core/api/api_consumer.dart';
import '../models/prayer_models.dart';

abstract class PrayerRemoteDataSource {
  Future<PrayerTimeModel?> getPrayerTime();
}

class PrayerRemoteDataSourceImpl implements PrayerRemoteDataSource {
  final ApiConsumerService apiConsumerService;

  PrayerRemoteDataSourceImpl({required this.apiConsumerService});
  @override
  Future<PrayerTimeModel?> getPrayerTime() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      final formattedDate = DateTime.now().toIso8601String();
      final response = await apiConsumerService.get(
          url:
              'https://api.aladhan.com/v1/timings/$formattedDate?latitude=${currentPosition.latitude}&longitude=${currentPosition.longitude}&method=4');
      return PrayerTimeModel.fromJson(response);
    }
    return null;
  }
}
