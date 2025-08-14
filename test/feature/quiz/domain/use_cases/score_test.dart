import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/feature/quiz/presentation/riverpod/quiz_game_provider.dart';

void main() {
  group('Score Calculation Tests', () {
    group('totalScore', () {
      test('should calculate correct total from score array', () {
        const state = QuizGameState(scoreArray: [1, 0, 1, 1, 0]);
        expect(state.totalScore, equals(3));
      });

      test('should return 0 for empty score array', () {
        const state = QuizGameState();
        expect(state.totalScore, equals(0));
      });

      test('should return 0 for all wrong answers', () {
        const state = QuizGameState(scoreArray: [0, 0, 0, 0]);
        expect(state.totalScore, equals(0));
      });

      test('should return full score for all correct answers', () {
        const state = QuizGameState(scoreArray: [1, 1, 1, 1, 1]);
        expect(state.totalScore, equals(5));
      });
    });

    group('hasPassed', () {
      test('should return true when score meets minimum requirement', () {
        const state = QuizGameState(scoreArray: [1, 1, 1, 1, 1]); // Score = 5
        expect(state.hasPassed, isTrue);
      });

      test('should return false when score is below minimum requirement', () {
        const state = QuizGameState(scoreArray: [1, 1, 0, 0, 0]); // Score = 2
        expect(state.hasPassed, isFalse);
      });

      test('should return true when score exceeds minimum requirement', () {
        const state =
            QuizGameState(scoreArray: [1, 1, 1, 1, 1, 1, 1]); // Score = 7
        expect(state.hasPassed, isTrue);
      });
    });
  });
}
