import 'dart:convert';

import 'package:my_app/feature/quiz/data/data_sources/quiz_data_source.dart';
import 'package:my_app/feature/quiz/domain/entities/quiz_entities.dart';
import 'package:my_app/feature/quiz/domain/repositories/quiz_repostiroy.dart';

class QuizRepositoryImpl implements QuizRepository {
  QuizRepositoryImpl({
    required this.dataSource,
  });

  final QuizDataSource dataSource;

  @override
  Future<(String?, List<Quiz>?)> getQuizes() async {
    try {
      final rawData = await dataSource.getQuizes();
      final quizes = rawData.map(Quiz.fromJson).toList();
      return (null, quizes);
    } catch (e) {
      return (e.toString(), null);
    }
  }

  @override
  (String?, List<Score>) getScores() {
    try {
      final rawData = dataSource.getScores();
      final scores = rawData.map(Score.fromJson).toList();
      return (null, scores);
    } catch (e) {
      return (e.toString(), []);
    }
  }

  @override
  Future<(String?, bool)> saveScore({required Score score}) async {
    try {
      final (error, currentScores) = getScores();
      if (error != null) return (error, false);

      final existingIndex =
          currentScores.indexWhere((s) => s.uuid == score.uuid);
      if (existingIndex != -1) {
        currentScores[existingIndex] = score;
      } else {
        currentScores.add(score);
      }

      return saveScores(scores: currentScores);
    } catch (e) {
      return (e.toString(), false);
    }
  }

  @override
  Future<(String?, bool)> saveScores({required List<Score> scores}) async {
    try {
      final jsonString =
          json.encode(scores.map((score) => score.toJson()).toList());
      final success = await dataSource.saveScores(data: jsonString);
      return (null, success);
    } catch (e) {
      return (e.toString(), false);
    }
  }
}
