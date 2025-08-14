import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/utils/utils.dart';
import 'package:my_app/feature/quiz/domain/entities/quiz_entities.dart';
import 'package:my_app/feature/quiz/domain/use_cases/score.dart';

class LeaderBoardState {
  const LeaderBoardState({
    this.scores = const [],
    this.error,
  });

  final List<Score> scores;
  final String? error;
  LeaderBoardState copyWith({
    List<Score>? scores,
    String? error,
  }) {
    return LeaderBoardState(
      scores: scores ?? this.scores,
      error: error ?? this.error,
    );
  }

  List<Score> get sortedScores {
    final sortedScores = List<Score>.from(scores)
      ..sort((a, b) => b.score.compareTo(a.score));
    return sortedScores;
  }

  List<Score> get topTenScores {
    final sortedScores = List<Score>.from(scores)
      ..sort((a, b) => b.score.compareTo(a.score));
    return sortedScores.take(10).toList();
  }

  List<Score> get topThree {
    return sortedScores.take(3).toList();
  }

  List<Score> get rest {
    return sortedScores.skip(3).toList();
  }
}

final leaderBoardProvider =
    NotifierProvider<LeaderBoardNotifier, LeaderBoardState>(
  LeaderBoardNotifier.new,
);

///We Could Break this Down to 2 separate Notifiers but to keep it simple
///we will just use One Notifier to Control and view LeaderBoard
class LeaderBoardNotifier extends Notifier<LeaderBoardState> {
  late final ScoresUseCase _scoresUseCase;

  @override
  LeaderBoardState build() {
    _scoresUseCase = ref.read(scoresUseCaseProvider);
    Future.microtask(getScores);
    return const LeaderBoardState();
  }

  Future<void> saveScore({required String name, required int score}) async {
    final (String? message, bool result) =
        await _scoresUseCase.save(playerName: name, score: score);
    if (message != null) {
      state = state.copyWith(error: message);
    } else {
      if (!result) {
        state = state.copyWith(error: 'Error Saving Score');
      } else {
        getScores();
      }
    }
  }

  void getScores() {
    final (String? message, List<Score> result) = _scoresUseCase.getScore();
    if (message != null) {
      Log.error(message);
      state = state.copyWith(error: message);
    } else {
      if (result.isEmpty) {
        Log.error('No Scores Found');
        state = state.copyWith(error: 'No Scores Found');
      } else {
        state = state.copyWith(scores: result);
      }
    }
  }
}
