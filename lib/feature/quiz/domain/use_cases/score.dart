import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/feature/quiz/domain/entities/quiz_entities.dart';
import 'package:my_app/feature/quiz/domain/repositories/quiz_repostiroy.dart';
import 'package:uuid/uuid.dart';

final scoresUseCaseProvider = Provider(
  (ref) => ScoresUseCase(
    repository: ref.read(quizRepositoryProvider),
  ),
);

class ScoresUseCase {
  ScoresUseCase({required this.repository});

  final QuizRepository repository;

  (String?, List<Score>) getScore() {
    return repository.getScores();
  }

  Future<(String?, bool)> save({
    required String playerName,
    required int score,
    DateTime? timestamp,
  }) async {
    final scoreEntity = Score(
      uuid: const Uuid().v4(),
      name: playerName,
      score: score,
      timestamp: timestamp ?? DateTime.now(),
    );

    return repository.saveScore(score: scoreEntity);
  }
}
