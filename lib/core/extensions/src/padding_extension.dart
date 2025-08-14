part of '../extensions.dart';

extension PaddingExtension on num {
  /// Creates a [SizedBox] with the specified height in responsive units.
  ///
  /// Uses the current number value as height and converts it to responsive
  /// height units using the `.h` extension.
  ///
  /// Example:
  /// ```dart
  /// 16.ph // Creates SizedBox(height: 16.h)
  /// ```
  SizedBox get ph => SizedBox(height: toDouble().h);

  /// Creates a [SizedBox] with the specified width in responsive units.
  ///
  /// Uses the current number value as width and converts it to responsive
  /// width units using the `.w` extension.
  ///
  /// Example:
  /// ```dart
  /// 16.pw // Creates SizedBox(width: 16.w)
  /// ```
  SizedBox get pw => SizedBox(width: toDouble().w);
}
