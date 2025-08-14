import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/core/extensions/extensions.dart';
import 'package:my_app/core/utils/config.dart';

class QuizTimerWidget extends StatelessWidget {
  const QuizTimerWidget({required this.value, super.key});
  final int value;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 100),
      scale: value.isEven ? 1.0 : 0.95,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 0.3.sw,
        width: 0.3.sw,
        decoration: context.boxDecor.basic().copyWith(
              color: Color.lerp(
                    context.appTheme.danger,
                    context.appTheme.success,
                    value / timerPerQuestion,
                  ) ??
                  context.appTheme.danger,
            ),
        child: AnimatedFlipCounter(
          duration: const Duration(milliseconds: 500),
          wholeDigits: 2,
          textStyle: context.texts.headline1.copyWith(
            color: Color.lerp(
                  context.appTheme.onDanger,
                  context.appTheme.onSuccess,
                  value / timerPerQuestion,
                ) ??
                context.appTheme.onDanger,
          ),
          value: value, // pass in a value like 2014
        ),
      ),
    );
  }
}
