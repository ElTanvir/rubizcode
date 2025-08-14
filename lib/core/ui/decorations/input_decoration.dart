import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/core/extensions/extensions.dart';

class AppInputDecorationStyles {
  const AppInputDecorationStyles(this.context);
  final BuildContext context;
  InputDecoration outlinedInputDecor({
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
    return InputDecoration(
      fillColor: fillColor ?? context.appTheme.surface,
      prefixIcon: prefix,
      suffixIcon: suffix,
      filled: true,
      counterText: counterText,
      helperText: helperText,
      helperStyle: helperTextStyle,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.appTheme.radius),
        borderSide: BorderSide(
          color: focusColor ?? context.appTheme.outline,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.appTheme.radius),
        borderSide: BorderSide(
          color: focusColor ?? context.appTheme.outline.setOpacity(0.5),
        ),
      ),
      hintText: hint,
      hintMaxLines: 2,
      hintStyle: hintTextStyle ??
          context.texts.subtitle1.copyWith(
            color: context.appTheme.onSurface.withValues(alpha: 0.5),
            fontSize: 14.sp,
          ),
      label: label,
      labelStyle: context.texts.subtitle1.copyWith(
        color: context.appTheme.primary,
        fontSize: 14.sp,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 0.04.sw,
        vertical: 0.03.sw,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.appTheme.radius),
        borderSide: BorderSide(
          color: context.appTheme.outline,
          // color: context.appTheme.outline.withOpacity(0.5),
        ),
      ),
      errorMaxLines: 4,
    );
  }
}
