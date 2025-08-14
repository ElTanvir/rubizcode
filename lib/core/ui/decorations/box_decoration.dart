import 'package:flutter/material.dart';
import 'package:my_app/core/extensions/extensions.dart';

class AppBoxDecorationStyles {
  const AppBoxDecorationStyles(this.context);
  final BuildContext context;
  BoxDecoration basic({
    String? hint,
    void Function()? clearText,
    String? counterText,
    Widget? prefix,
    Widget? suffix,
    Color? focusColor,
    Color? fillColor,
    TextStyle? hintTextStyle,
    String? helperText,
    Widget? label,
    TextStyle? helperTextStyle,
  }) {
    return BoxDecoration(
      color: context.appTheme.surface,
      borderRadius: BorderRadius.circular(
        context.appTheme.radius,
      ),
      boxShadow: [
        BoxShadow(
          color: context.appTheme.onSurface,
          spreadRadius: 1,
          offset: const Offset(4, 4),
        ),
      ],
      border: Border.all(
        color: context.appTheme.onSurface,
      ),
    );
  }
}
