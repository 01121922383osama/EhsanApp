import '../../../../../core/api/api_consumer.dart';
import '../../../../../core/api/end_point.dart';
import '../../models/surah_models.dart';

abstract class QuranRemoteDataSource {
  Future<List<SurahModels>> getAllQuran();
}

class QuranRemoteDataSourceImpl extends QuranRemoteDataSource {
  final ApiConsumerService apiConsumerService;

  QuranRemoteDataSourceImpl({required this.apiConsumerService});

  @override
  Future<List<SurahModels>> getAllQuran() async {
    final List<dynamic> response =
        await apiConsumerService.get(url: EndPoint.baseURL);
    return response.map((e) => SurahModels.fromJson(e)).toList();
  }
}
