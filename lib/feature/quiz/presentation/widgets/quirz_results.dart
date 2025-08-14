import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/core/ui/assets/app_assets.dart';

class QuizResultAnimation extends StatelessWidget {
  const QuizResultAnimation({required this.hasPassed, super.key});
  final bool hasPassed;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      hasPassed ? AppAssets.lotties.success : AppAssets.lotties.failure,
    );
  }
}
