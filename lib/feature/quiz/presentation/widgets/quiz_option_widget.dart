import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latext/latext.dart';
import 'package:my_app/core/extensions/extensions.dart';

class QuizOptionWidget extends ConsumerWidget {
  const QuizOptionWidget({
    required this.value,
    required this.isSelected,
    super.key,
    this.onTap,
    this.hasBottomPadding = true,
  });
  final String value;
  final void Function()? onTap;
  final bool isSelected;
  final bool hasBottomPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: hasBottomPadding ? 16.h : 0,
        ),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 300),
          scale: isSelected ? 1 : 0.95,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 1.sw,
            decoration: context.boxDecor.basic().copyWith(
                  color: isSelected
                      ? context.appTheme.primary
                      : context.appTheme.surface,
                ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: LaTexT(
                laTeXCode: Text(
                  value,
                  style: context.texts.subtitle1.copyWith(
                    color: isSelected
                        ? context.appTheme.onPrimary
                        : context.appTheme.onSurface,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
