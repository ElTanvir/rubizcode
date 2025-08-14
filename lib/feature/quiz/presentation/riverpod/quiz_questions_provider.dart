import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/utils/utils.dart';
import 'package:my_app/feature/quiz/domain/entities/quiz_entities.dart';
import 'package:my_app/feature/quiz/domain/use_cases/get_quizes.dart';

class QuizQuestionsState {
  const QuizQuestionsState({
    this.questions = const [],
    this.isLoading = true,
    this.error,
  });

  final List<Quiz> questions;
  final bool isLoading;
  final String? error;

  QuizQuestionsState copyWith({
    List<Quiz>? questions,
    bool? isLoading,
    String? error,
  }) {
    return QuizQuestionsState(
      questions: questions ?? this.questions,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  List<Quiz> getRandomQuestions({int count = 10}) {
    if (questions.length <= count) return questions;
    final random = Random();
    final indices = <int>{};

    while (indices.length < count) {
      indices.add(random.nextInt(questions.length));
    }
    return indices.map((index) => questions[index]).toList();
  }
}

final quizQuestionsProvider =
    NotifierProvider<QuizQuestionsNotifier, QuizQuestionsState>(
  QuizQuestionsNotifier.new,
);

class QuizQuestionsNotifier extends Notifier<QuizQuestionsState> {
  late final GetQuizesUseCase _getQuizesUseCase;

  @override
  QuizQuestionsState build() {
    _getQuizesUseCase = ref.read(getQuizesUseCaseProvider);
    Future.microtask(loadQuestions);
    return const QuizQuestionsState();
  }

  Future<void> loadQuestions() async {
    state = state.copyWith(isLoading: true);

    final (error, questions) = await _getQuizesUseCase();

    if (error != null) {
      Log.error('Error loading quiz: $error');
      state = state.copyWith(isLoading: false, error: error);
    } else if (questions != null) {
      Log.info('Quiz loaded successfully: ${questions.length} questions');
      state = state.copyWith(
        isLoading: false,
        questions: questions,
      );
    } else {
      Log.error('Quiz loading returned null questions');
      state = state.copyWith(isLoading: false);
    }
  }
}
