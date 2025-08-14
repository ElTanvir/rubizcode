import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/core/extensions/extensions.dart';
import 'package:my_app/core/services/cache/cache_provider.dart';

part './colors.dart';
part './layout/breakpoints.dart';
part './typography/font_weights.dart';
part './typography/text_styles.dart';

final themeProvider = NotifierProvider<AppThemeNotifier, AppThemeNotifierState>(
  AppThemeNotifier.new,
);

class AppThemeNotifier extends Notifier<AppThemeNotifierState> {
  late final CacheService _cacheService;
  @override
  AppThemeNotifierState build() {
    Future.microtask(() async {
      _cacheService = ref.read(cacheServiceProvider);
      await _readCache();
    });
    return AppThemeNotifierState(
      themeData: _compileThemeData('light'),
      themeValue: 'light',
    );
  }

  Future<void> _readCache() async {
    const themeKey = 'apptheme';
    final cachedthemevalue = _cacheService.retrieve<String>(themeKey);

    if (cachedthemevalue != null) {
      state = state.copyWith(
        themeData: _compileThemeData(cachedthemevalue),
        themeValue: cachedthemevalue,
      );
    } else {
      unawaited(_cacheService.save(themeKey, state.themeValue));
    }
  }

  Future<void> toggleTheme() async {
    const themeKey = 'apptheme';
    final themeValue = state.themeValue == 'light' ? 'dark' : 'light';
    state = state.copyWith(
      themeData: _compileThemeData(
        themeValue,
      ),
      themeValue: themeValue,
    );
    unawaited(_cacheService.save(themeKey, themeValue));
  }

  ThemeData _compileThemeData(String themeValue) {
    final colorScheme = themeValue == 'light'
        ? AppColorSchemes.lightColorScheme
        : AppColorSchemes.darkColorScheme;

    final themeData = ThemeDefinations.themeByValue(themeValue);

    final primaryColor = themeData.primary;
    final onPrimaryColor = themeData.onPrimary;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: colorScheme.brightness,
      scaffoldBackgroundColor: themeData.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
    );
  }
}

class AppThemeNotifierState {
  AppThemeNotifierState({required this.themeData, required this.themeValue});

  final ThemeData themeData;
  final String themeValue;
  AppThemeNotifierState copyWith({
    ThemeData? themeData,
    String? themeValue,
  }) {
    return AppThemeNotifierState(
      themeData: themeData ?? this.themeData,
      themeValue: themeValue ?? this.themeValue,
    );
  }

  bool get isDark => themeValue == 'dark';
}

class AppThemeService {
  AppThemeService(this.context);
  final BuildContext context;
  AppTheme get themeData => Theme.of(context).brightness == Brightness.light
      ? ThemeDefinations.lightTheme
      : ThemeDefinations.darkTheme;
}

class ThemeDefinations {
  ThemeDefinations._();
  static final AppTheme lightTheme = AppTheme(
    surface: ColorConst.white,
    surfaceAlt: ColorConst.neutral50,
    onSurface: ColorConst.black,
    onSurfaceStrong: ColorConst.black,
    primary: ColorConst.violet500,
    onPrimary: ColorConst.white,
    secondary: ColorConst.lime400,
    onSecondary: ColorConst.black,
    outline: ColorConst.black,
    outlineStrong: ColorConst.black,
    info: ColorConst.sky600,
    onInfo: ColorConst.black,
    success: ColorConst.green600,
    onSuccess: ColorConst.black,
    warning: ColorConst.amber500,
    onWarning: ColorConst.black,
    danger: ColorConst.red500,
    onDanger: ColorConst.black,
    radius: 0,
  );

  // Dark theme colors
  static final AppTheme darkTheme = AppTheme(
    surface: ColorConst.neutral950,
    surfaceAlt: ColorConst.neutral800,
    onSurface: ColorConst.neutral200,
    onSurfaceStrong: ColorConst.white,
    primary: ColorConst.violet400,
    onPrimary: ColorConst.black,
    secondary: ColorConst.lime300,
    onSecondary: ColorConst.black,
    outline: ColorConst.neutral300,
    outlineStrong: ColorConst.white,
    info: ColorConst.sky600,
    onInfo: ColorConst.black,
    success: ColorConst.green600,
    onSuccess: ColorConst.black,
    warning: ColorConst.amber500,
    onWarning: ColorConst.black,
    danger: ColorConst.red500,
    onDanger: ColorConst.black,
    radius: 0,
  );

  static AppTheme themeByValue(String themeValue) =>
      themeValue == 'light' ? lightTheme : darkTheme;
}
