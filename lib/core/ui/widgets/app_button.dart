import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/core/extensions/extensions.dart';

enum AppButtonVariant { filled, outlined }

class AppButton extends StatefulWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.onLongPressed,
    this.variant = AppButtonVariant.filled,
    this.background,
    this.textStyle,
    this.height = 50,
    this.width,
    this.isLoading = false,
    this.prefix,
    this.suffix,
    this.isDisabled = false,
    this.hasBoxShadow = false,
    this.padding,
    this.isCircular = false,
    this.progressIndicator,
  });

  factory AppButton.filled({
    required String label,
    required VoidCallback onPressed,
    VoidCallback? onLongPressed,
    Color? background,
    TextStyle? textStyle,
    double height = 50,
    double? width,
    bool isLoading = false,
    Widget? prefix,
    Widget? suffix,
    bool isDisabled = false,
    bool hasBoxShadow = true,
    EdgeInsetsGeometry? padding,
    Widget? progressIndicator,
  }) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      onLongPressed: onLongPressed,
      background: background,
      textStyle: textStyle,
      height: height,
      width: width,
      isLoading: isLoading,
      prefix: prefix,
      suffix: suffix,
      isDisabled: isDisabled,
      hasBoxShadow: hasBoxShadow,
      padding: padding,
      progressIndicator: progressIndicator,
    );
  }

  factory AppButton.outlined({
    required String label,
    required VoidCallback onPressed,
    VoidCallback? onLongPressed,
    Color? background,
    TextStyle? textStyle,
    double height = 48,
    double? width,
    bool isLoading = false,
    Widget? prefix,
    Widget? suffix,
    bool isDisabled = false,
    bool hasBoxShadow = true,
    EdgeInsetsGeometry? padding,
    Widget? progressIndicator,
  }) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      onLongPressed: onLongPressed,
      variant: AppButtonVariant.outlined,
      background: background,
      textStyle: textStyle,
      height: height,
      width: width,
      isLoading: isLoading,
      prefix: prefix,
      suffix: suffix,
      isDisabled: isDisabled,
      hasBoxShadow: hasBoxShadow,
      padding: padding,
      progressIndicator: progressIndicator,
    );
  }

  final String label;
  final VoidCallback onPressed;
  final VoidCallback? onLongPressed;
  final AppButtonVariant variant;
  final Color? background;
  final TextStyle? textStyle;
  final double height;
  final double? width;
  final bool isLoading;
  final Widget? prefix;
  final Widget? suffix;
  final bool isDisabled;
  final bool hasBoxShadow;
  final EdgeInsetsGeometry? padding;
  final bool isCircular;
  final Widget? progressIndicator;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  bool get _isInteractive => !widget.isDisabled && !widget.isLoading;
  bool get _isFilled => widget.variant == AppButtonVariant.filled;

  Color get _backgroundColor {
    if (!_isFilled) return Colors.transparent;
    if (widget.isDisabled) return Colors.grey;
    return widget.background ?? context.appTheme.primary;
  }

  Color get _textColor {
    if (widget.textStyle?.color != null) return widget.textStyle!.color!;
    return _isFilled ? context.appTheme.onPrimary : context.appTheme.primary;
  }

  Color get _borderColor {
    return context.appTheme.onSurface;
  }

  void _handleTap() {
    if (!_isInteractive) return;

    setState(() => _isPressed = true);
    widget.onPressed();

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) setState(() => _isPressed = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(context.appTheme.radius);

    return InkWell(
      onTap: _isInteractive ? _handleTap : null,
      onLongPress: _isInteractive ? widget.onLongPressed : null,
      borderRadius: widget.isCircular ? null : borderRadius,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: _isPressed ? 0.9 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: widget.height,
          width: widget.width ?? 1.sw,
          padding: widget.padding ?? EdgeInsets.zero,
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: widget.isCircular ? null : borderRadius,
            shape: widget.isCircular ? BoxShape.circle : BoxShape.rectangle,
            boxShadow: widget.hasBoxShadow
                ? [
                    BoxShadow(
                      color: context.appTheme.onSurface,
                      spreadRadius: 1,
                      offset: _isPressed ? Offset.zero : const Offset(4, 4),
                    ),
                  ]
                : null,
            border: _shouldShowBorder
                ? Border.all(
                    color: _borderColor,
                  )
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.prefix != null && !widget.isLoading) ...[
                widget.prefix!,
                if (widget.label.isNotEmpty) SizedBox(width: 8.w),
              ],
              if (widget.isLoading)
                SizedBox(
                  height: 20,
                  width: 20,
                  child: widget.progressIndicator ??
                      CircularProgressIndicator(
                        color: _textColor,
                        strokeWidth: 2,
                      ),
                )
              else if (widget.label.isNotEmpty)
                Flexible(
                  child: Text(
                    widget.label,
                    style: widget.textStyle ??
                        context.texts.button.copyWith(
                          color: _textColor,
                        ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
              if (widget.suffix != null && !widget.isLoading) ...[
                if (widget.label.isNotEmpty) SizedBox(width: 8.w),
                widget.suffix!,
              ],
            ],
          ),
        ),
      ),
    );
  }

  ///Adjust Logic depending on requirement
  ///for neo brutalism showing border is core principle
  ///so it is hardcoded to true
  bool get _shouldShowBorder => true;
}
