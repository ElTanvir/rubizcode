part of './theme.dart';

class AppTheme {
  AppTheme({
    required this.surface,
    required this.surfaceAlt,
    required this.onSurface,
    required this.onSurfaceStrong,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.outline,
    required this.outlineStrong,
    required this.info,
    required this.onInfo,
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.danger,
    required this.onDanger,
    required this.radius,
  });

  // Colors
  final Color surface;
  final Color surfaceAlt;
  final Color onSurface;
  final Color onSurfaceStrong;
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color outline;
  final Color outlineStrong;
  final Color info;
  final Color onInfo;
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color danger;
  final Color onDanger;

  // Border Radius
  final double radius;
}

abstract class AppColorSchemes {
  static const lightColorScheme = ColorScheme.light();
  static const darkColorScheme = ColorScheme.dark();
}

class ColorConst {
  // Base colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Neutral colors
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral200 = Color(0xFFE5E5E5);
  static const Color neutral300 = Color(0xFFD4D4D4);
  static const Color neutral800 = Color(0xFF262626);
  static const Color neutral950 = Color(0xFF0A0A0A);

  // Violet colors
  static const Color violet400 = Color(0xFF8B5CF6);
  static const Color violet500 = Color(0xFF7C3AED);

  // Lime colors
  static const Color lime300 = Color(0xFFBEF264);
  static const Color lime400 = Color(0xFFA3E635);

  // Sky colors
  static const Color sky600 = Color(0xFF0284C7);

  // Green colors
  static const Color green600 = Color(0xFF16A34A);

  // Amber colors
  static const Color amber500 = Color(0xFFF59E0B);

  // Red colors
  static const Color red500 = Color(0xFFEF4444);
}
