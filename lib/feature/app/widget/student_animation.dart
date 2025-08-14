import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/core/ui/assets/app_assets.dart';

class StudentAnimation extends StatelessWidget {
  const StudentAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(AppAssets.lotties.student);
  }
}
