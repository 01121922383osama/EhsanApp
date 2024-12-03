import '../entities/prayer_time_entity.dart';
import '../repositories/prayer_time_repo.dart';

class PrayerTimeUseCases {
  final PrayerTimeRepo prayerTimeRepo;

  PrayerTimeUseCases({required this.prayerTimeRepo});

  Future<PrayerTimeEntity?> getPrayerTime() async {
    return await prayerTimeRepo.getPrayerTime();
  }
}
