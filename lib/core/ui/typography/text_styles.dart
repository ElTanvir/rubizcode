part of '../theme.dart';

class AppTextStyles {
  AppTextStyles(this.context);

  final BuildContext context;

  /// Base text style with dynamic color from the theme's color scheme
  TextStyle get _baseTextStyle {
    return const TextStyle(
      fontFamily: 'CascadiaCode',
      fontWeight: AppFontWeight.regular,
    ).copyWith(
      color: context.appTheme.onSurface,
    );
  }

  ///48 medium
  TextStyle get headline1 {
    return _baseTextStyle.copyWith(
      fontSize: 48.sp,
      fontWeight: AppFontWeight.bold,
    );
  }

  ///30 regular
  TextStyle get headline2 {
    return _baseTextStyle.copyWith(
      fontSize: 30.sp,
      fontWeight: AppFontWeight.regular,
    );
  }

  ///28 regular
  TextStyle get headline3 {
    return _baseTextStyle.copyWith(
      fontSize: 28.sp,
      fontWeight: AppFontWeight.regular,
    );
  }

  ///22 bold
  TextStyle get headline4 {
    return _baseTextStyle.copyWith(
      fontSize: 22.sp,
      fontWeight: AppFontWeight.bold,
    );
  }

  ///20 medium
  TextStyle get headline5 {
    return _baseTextStyle.copyWith(
      fontSize: 20.sp,
      fontWeight: AppFontWeight.medium,
    );
  }

  ///18 bold
  TextStyle get headline6 {
    return _baseTextStyle.copyWith(
      fontSize: 18.sp,
      fontWeight: AppFontWeight.bold,
    );
  }

  ///18 medium
  TextStyle get bodyText1 {
    return _baseTextStyle.copyWith(
      fontSize: 18.sp,
      fontWeight: AppFontWeight.medium,
    );
  }

  ///18 medium
  TextStyle get button {
    return _baseTextStyle.copyWith(
      fontSize: 18.sp,
      fontWeight: AppFontWeight.medium,
    );
  }

  ///16 bold
  TextStyle get subtitle1 {
    return _baseTextStyle.copyWith(
      fontSize: 16.sp,
      fontWeight: AppFontWeight.bold,
    );
  }

  ///16 regular
  TextStyle get bodyText2 {
    return _baseTextStyle.copyWith(
      fontSize: 16.sp,
      fontWeight: AppFontWeight.regular,
    );
  }

  ///16 regular
  TextStyle get overLine {
    return _baseTextStyle.copyWith(
      fontSize: 16.sp,
      fontWeight: AppFontWeight.regular,
    );
  }

  ///14 bold
  TextStyle get subtitle2 {
    return _baseTextStyle.copyWith(
      fontSize: 14.sp,
      fontWeight: AppFontWeight.bold,
    );
  }

  ///14 regular
  TextStyle get caption {
    return _baseTextStyle.copyWith(
      fontSize: 14.sp,
      fontWeight: AppFontWeight.regular,
    );
  }

  ///12 regular
  TextStyle get caption2 {
    return _baseTextStyle.copyWith(
      fontSize: 12.sp,
      fontWeight: AppFontWeight.regular,
    );
  }
}
