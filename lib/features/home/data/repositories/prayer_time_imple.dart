import 'package:hive/hive.dart';

import '../../../../core/Network/network_info.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/prayer_time_entity.dart';
import '../../domain/repositories/prayer_time_repo.dart';
import '../datasources/prayer_local_datasource.dart';
import '../datasources/prayer_remote_datasource.dart';

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
      final prayerTime = await remoteDataSource.getPrayerTime();
      saveBooksData(
        prayerData: prayerTime!,
        boxName: AppString.keyPrayerTime,
      );
      return prayerTime;
    } else {
      final localData = await localDataSource.getPrayerTime();
      return localData.first;
    }
  }
}

void saveBooksData({
  required PrayerTimeEntity prayerData,
  required String boxName,
}) {
  var box = Hive.box<PrayerTimeEntity>(boxName);
  box.add(prayerData);
}
