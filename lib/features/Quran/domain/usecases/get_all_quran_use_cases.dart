import 'package:dartz/dartz.dart';
import '../../../../core/Error/error.dart';
import '../entities/surah_entity.dart';
import '../repositories/quran_repo.dart';

class GetAllQuranUseCases {
  final QuranRepo quranRepo;

  GetAllQuranUseCases({required this.quranRepo});
  Future<Either<Failure, List<SurahEntity>>> getAllQuran() async {
    return await quranRepo.getAllQuran();
  }
}
