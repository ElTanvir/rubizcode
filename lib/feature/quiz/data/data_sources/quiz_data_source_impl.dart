part of 'quiz_data_source.dart';

class QuizDataSourceImpl implements QuizDataSource {
  QuizDataSourceImpl({required this.cacheService});
  final CacheService cacheService;

  @override
  Future<List<Map<String, dynamic>>> getQuizes() async {
    final jsonString = await rootBundle.loadString('assets/questions.json');
    final jsonList = json.decode(jsonString) as List<dynamic>;
    return jsonList.cast<Map<String, dynamic>>();
  }

  @override
  List<Map<String, dynamic>> getScores() {
    final data = cacheService.retrieve<String>(CacheKeys.score);
    if (data != null) {
      final jsonList = json.decode(data) as List<dynamic>;
      return jsonList.cast<Map<String, dynamic>>();
    }
    return [];
  }

  @override
  Future<bool> saveScores({required String data}) {
    return cacheService.save(CacheKeys.score, data);
  }
}
