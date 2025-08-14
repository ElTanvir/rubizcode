import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/utils/utils.dart';
import 'package:my_app/feature/quiz/domain/entities/quiz_entities.dart';
import 'package:my_app/feature/quiz/domain/repositories/quiz_repostiroy.dart';

final getQuizesUseCaseProvider = Provider(
  (ref) => GetQuizesUseCase(
    repository: ref.read(quizRepositoryProvider),
  ),
);

class GetQuizesUseCase {
  GetQuizesUseCase({required this.repository});

  final QuizRepository repository;

  Future<(String?, List<Quiz>?)> call() async {
    Log.info('Fetching Quizes');
    return repository.getQuizes();
  }
}
