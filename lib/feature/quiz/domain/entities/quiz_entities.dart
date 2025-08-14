import 'package:equatable/equatable.dart';

/// Entity representing a quiz question
class Quiz extends Equatable {
  const Quiz({
    required this.question,
    required this.options,
    required this.answerIndex,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>).cast<String>(),
      answerIndex: json['answer_index'] as int,
    );
  }

  /// The question text (may contain LaTeX formatting)
  final String question;
  //hello

  /// List of answer options (may contain LaTeX formatting)
  final List<String> options;

  /// Index of the correct answer in the options list
  final int answerIndex;

  /// Get the correct answer text
  String get correctAnswer => options[answerIndex];

  /// Check if the given option index is correct
  bool isCorrectAnswer(int selectedIndex) => selectedIndex == answerIndex;

  @override
  List<Object?> get props => [question, options, answerIndex];
}

/// Entity representing a user's quiz score
class Score extends Equatable {
  const Score({
    required this.uuid,
    required this.name,
    required this.score,
    this.timestamp,
  });

  /// Create Score from JSON
  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      score: json['score'] as int,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : null,
    );
  }

  /// Unique identifier for the score entry
  final String uuid;

  /// User's name
  final String name;

  /// The score achieved
  final int score;

  /// When the score was achieved (optional)
  final DateTime? timestamp;

  /// Convert Score to JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'score': score,
      'timestamp': timestamp?.toIso8601String(),
    };
  }

  /// Create a copy with updated values
  Score copyWith({
    String? uuid,
    String? name,
    int? score,
    DateTime? timestamp,
  }) {
    return Score(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      score: score ?? this.score,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [uuid, name, score, timestamp];
}
