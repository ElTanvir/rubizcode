part of '../extensions.dart';

extension AppThemes on BuildContext {
  AppTheme get appTheme => AppThemeService(this).themeData;
}

extension AppInputDecorExtension on BuildContext {
  AppInputDecorationStyles get inputDecor => AppInputDecorationStyles(this);
}

extension AppBoxDecorExtension on BuildContext {
  AppBoxDecorationStyles get boxDecor => AppBoxDecorationStyles(this);
}

extension OpacityExtension on Color {
  Color setOpacity(double opacity) {
    if (opacity < 0.0 || opacity > 1.0) {
      throw RangeError.range(
        opacity,
        0,
        1,
        'opacity',
        'Opacity must be between 0.0 and 1.0 inclusive.',
      );
    }
    return withAlpha(
      (opacity * 255).round(),
    );
  }
}
