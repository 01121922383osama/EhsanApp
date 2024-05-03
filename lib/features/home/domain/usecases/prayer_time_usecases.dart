import 'package:free_lancer/features/home/domain/entities/prayer_time_entity.dart';
import 'package:free_lancer/features/home/domain/repositories/prayer_time_repo.dart';

class PrayerTimeUseCases {
  final PrayerTimeRepo prayerTimeRepo;

  PrayerTimeUseCases({required this.prayerTimeRepo});

  Future<PrayerTimeEntity> getPrayerTime() async {
    return await prayerTimeRepo.getPrayerTime();
  }
}
