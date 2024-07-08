import 'package:dartz/dartz.dart';

import '../../../../core/Error/error.dart';
import '../entities/surah_entity.dart';

abstract class QuranRepo {
  Future<Either<Failure, List<SurahEntity>>> getAllQuran();
}
