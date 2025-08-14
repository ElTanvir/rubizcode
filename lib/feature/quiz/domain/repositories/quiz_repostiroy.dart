import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/feature/quiz/data/data_sources/quiz_data_source.dart';
import 'package:my_app/feature/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:my_app/feature/quiz/domain/entities/quiz_entities.dart';

final quizRepositoryProvider = Provider(
  (ref) => QuizRepositoryImpl(
    dataSource: ref.read(quizDataSourceProvider),
  ),
);

abstract class QuizRepository {
  Future<(String?, List<Quiz>?)> getQuizes();
  Future<(String?, bool)> saveScore({required Score score});
  Future<(String?, bool)> saveScores({required List<Score> scores});
  (String?, List<Score>) getScores();
}
