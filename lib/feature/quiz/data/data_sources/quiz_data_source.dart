import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/services/cache/cache_provider.dart';

part 'quiz_data_source_impl.dart';

final quizDataSourceProvider = Provider(
  (ref) => QuizDataSourceImpl(
    cacheService: ref.read(cacheServiceProvider),
  ),
);

abstract class QuizDataSource {
  Future<List<Map<String, dynamic>>> getQuizes();
  Future<bool> saveScores({required String data});
  List<Map<String, dynamic>> getScores();
}
