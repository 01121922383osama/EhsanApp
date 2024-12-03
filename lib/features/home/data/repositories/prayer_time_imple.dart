import 'package:flutter/material.dart';
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
  Future<PrayerTimeEntity?> getPrayerTime() async {
    if (await networkInfo.isConnected) {
      final box = Hive.box<PrayerTimeEntity>(AppString.keyPrayerTime);
      final prayerTime = await remoteDataSource.getPrayerTime();
      await box.clear();
      savePrayersData(
        prayerData: prayerTime!,
      );
      return prayerTime;
    } else {
      final localData = localDataSource.getPrayerTime();
      return localData;
    }
  }
}

Future<void> savePrayersData({required PrayerTimeEntity prayerData}) async {
  try {
    final box = Hive.box<PrayerTimeEntity>(AppString.keyPrayerTime);
    await box.put(AppString.keyPrayerTime, prayerData);
  } catch (e) {
    debugPrint("Error saving prayer time data locally: $e");
  }
}
