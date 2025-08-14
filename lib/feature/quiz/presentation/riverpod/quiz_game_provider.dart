import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/utils/config.dart';
import 'package:my_app/core/utils/utils.dart';
import 'package:my_app/feature/quiz/domain/entities/quiz_entities.dart';
import 'package:my_app/feature/quiz/presentation/riverpod/quiz_questions_provider.dart';

class QuizGameState {
  const QuizGameState({
    this.questions = const [],
    this.error,
    this.currentQuestionIndex = 0,
    this.scoreArray = const [],
    this.secondsRemaining = timerPerQuestion,
  });

  final List<Quiz> questions;
  final int currentQuestionIndex;
  final List<int> scoreArray;
  final String? error;
  final int secondsRemaining;
  QuizGameState copyWith({
    List<Quiz>? questions,
    int? currentQuestionIndex,
    List<int>? scoreArray,
    String? error,
    int? secondsRemaining,
  }) {
    return QuizGameState(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      scoreArray: scoreArray ?? this.scoreArray,
      error: error ?? this.error,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
    );
  }

  Quiz? get currentQuestion {
    if (questions.isNotEmpty && currentQuestionIndex < questions.length) {
      return questions[currentQuestionIndex];
    }
    return null;
  }

  bool get isQuizCompleted {
    return currentQuestionIndex >= questions.length;
  }

  bool get isLastQuestion {
    return currentQuestionIndex == questions.length - 1;
  }

  int get totalScore {
    if (scoreArray.isEmpty) {
      return 0;
    }
    return scoreArray.reduce((value, element) => value + element);
  }

  int get maxScore {
    return questions.length;
  }

  bool get hasPassed {
    return totalScore >= minScoreToPass;
  }
}

final quizGameProvider = NotifierProvider<QuizGameNotifier, QuizGameState>(
  QuizGameNotifier.new,
);

class QuizGameNotifier extends Notifier<QuizGameState> {
  Timer? _timer;

  @override
  QuizGameState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return const QuizGameState();
  }

  void initiateGame() {
    resetGame();
    //by Default this starts the game with 10 questions
    final questions = ref.read(quizQuestionsProvider).getRandomQuestions();

    if (questions.isEmpty) {
      Log.error('No questions available');
      state = state.copyWith(
        error: 'No questions available',
      );
      return;
    } else {
      Log.info('Quiz loaded successfully: ${questions.length} questions');
      state = state.copyWith(
        questions: questions,
        secondsRemaining: timerPerQuestion,
        scoreArray: List.generate(questions.length, (index) => 0),
      );
      startTimer();
    }
  }

  void answerQuestion(int? answerIndex) {
    final currentQuestion = state.questions[state.currentQuestionIndex];
    final isCorrect = currentQuestion.answerIndex == answerIndex;
    final updatedScoreArray = List<int>.from(state.scoreArray);
    updatedScoreArray[state.currentQuestionIndex] = isCorrect ? 1 : 0;

    state = state.copyWith(
      scoreArray: updatedScoreArray,
    );

    if (state.currentQuestionIndex < state.questions.length - 1) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
        secondsRemaining: timerPerQuestion,
      );
      startTimer();
    } else {
      Log.info('Quiz completed');
      // onGameCompleted();
    }
  }

  void resetGame() {
    stopTimer();
    state = const QuizGameState();
  }

  void startTimer() {
    stopTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining > 0) {
        state = state.copyWith(
          secondsRemaining: state.secondsRemaining - 1,
        );
      } else {
        stopTimer();
        onTimeUp();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void onTimeUp() {
    //answer current Question with null which means
    //user failed to answer on time
    answerQuestion(null);
  }

  void onGameCompleted() {
    //answer current Question with null which means
    //user failed to answer on time
    resetGame();
  }

  void restartGame() {
    initiateGame();
  }
}
