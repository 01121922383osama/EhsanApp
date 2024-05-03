import 'package:dartz/dartz.dart';
import '../../../../core/Error/error.dart';
import '../../../../core/Error/exceptions.dart';
import '../../../../core/Network/network_info.dart';
import '../datasources/LocalDataSource/quran_local_datasource.dart';
import '../datasources/RemoteDataSource/quran_remote_datasource.dart';
import '../../domain/entities/surah_entity.dart';
import '../../domain/repositories/quran_repo.dart';

class QuranRepoImpl implements QuranRepo {
  final QuranRemoteDataSource quranRemoteDataSource;
  final QuranLocalDataSource quranLocalDataSource;
  final NetworkInfo networkInfo;
  QuranRepoImpl({
    required this.quranRemoteDataSource,
    required this.quranLocalDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<SurahEntity>>> getAllQuran() async {
    if (await networkInfo.isConnected) {
      try {
        final remote = await quranRemoteDataSource.getAllQuran();
        return Right(remote);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final local = <SurahEntity>[];
        return Right(local);
      } on CacheException {
        return left(CacheFailure());
      }
    }
  }
}
