import 'package:free_lancer/core/Network/network_info.dart';
import 'package:free_lancer/features/home/data/datasources/prayer_local_datasource.dart';
import 'package:free_lancer/features/home/data/datasources/prayer_remote_datasource.dart';
import 'package:free_lancer/features/home/domain/entities/prayer_time_entity.dart';
import 'package:free_lancer/features/home/domain/repositories/prayer_time_repo.dart';

class PrayerTimeImple implements PrayerTimeRepo {
  final PrayerRemoteDataSource remoteDataSource;
  final PrayerTimeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PrayerTimeImple({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<PrayerTimeEntity> getPrayerTime() async {
    if (await networkInfo.isConnected) {
      return await remoteDataSource.getPrayerTime();
    } else {
      return await localDataSource.getPrayerTime();
    }
  }
}
