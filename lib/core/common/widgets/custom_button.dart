import 'package:flutter/material.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import '../../utils/constants/app_colors.dart';
import '../widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final dynamic backgroundColor; // Color or Gradient
  final Color? textColor;
  final bool isOutline;
  final Color? borderColor;
  final TextStyle? customTextStyle;
  final double? width;
  final double? height;
  final bool isUpperCase;
  final double? elevation;
  final bool enableShadow;
  final bool isLoading;

  /// NEW (font control)
  final bool poppins;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.child,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.textColor,
    this.isOutline = false,
    this.borderColor,
    this.customTextStyle,
    this.width,
    this.height = 48,
    this.isUpperCase = false,
    this.elevation,
    this.enableShadow = false,
    this.poppins = false, // default Inter
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadius effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(8.h);

    final bool hasGradient = backgroundColor is Gradient;

    final Color effectiveTextColor = isOutline
        ? (textColor ?? Theme.of(context).primaryColor)
        : (textColor ?? AppColors.white);

    return Material(
      color: AppColors.white.withAlpha(0),
      borderRadius: effectiveBorderRadius,
      elevation: elevation ?? 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: effectiveBorderRadius,
        splashColor: AppColors.white.withAlpha(25),
        child: Container(
          width: width ?? double.infinity,
          height: height,
          padding:
              padding ??
              const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            gradient: hasGradient ? backgroundColor : null,
            color: !hasGradient ? (backgroundColor ?? AppColors.primary) : null,
            borderRadius: effectiveBorderRadius,
            border: isOutline
                ? Border.all(
                    color: borderColor ?? Theme.of(context).primaryColor,
                  )
                : null,
            boxShadow: enableShadow
                ? [
                    BoxShadow(
                      color: AppColors.black.withAlpha(25),
                      offset: const Offset(0, 4),
                      blurRadius: 8,
                    ),
                  ]
                : [],
          ),
          child: isLoading
              ? Center(
                  child: SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: CircularProgressIndicator(
                      color: effectiveTextColor,
                      strokeWidth: 2,
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (prefixIcon != null) ...[
                      prefixIcon!,
                      const SizedBox(width: 8),
                    ],

                    if (child == null)
                      Flexible(
                        child: CustomText(
                          text: isUpperCase ? text.toUpperCase() : text,
                          fontSize: customTextStyle?.fontSize ?? 14.sp,
                          fontWeight:
                              customTextStyle?.fontWeight ?? FontWeight.w600,
                          color: effectiveTextColor,
                          textAlign: TextAlign.center,
                          poppins: poppins,
                        ),
                      ),

                    if (child != null) child!,

                    if (suffixIcon != null) ...[
                      const SizedBox(width: 8),
                      suffixIcon!,
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
