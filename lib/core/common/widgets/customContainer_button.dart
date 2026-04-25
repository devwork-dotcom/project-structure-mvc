import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_sizer.dart';
import 'custom_text.dart';

class CustomContainerButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  /// Optional styles
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;

  const CustomContainerButton({
    super.key,
    required this.text,
    required this.onTap,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius ?? 33.h),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primary,
          borderRadius: BorderRadius.circular(borderRadius ?? 33.h),
          border: Border.all(
            width: borderWidth ?? 1.h,
            color: borderColor ?? AppColors.primary,
          ),
        ),
        child: Padding(
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 12.h, vertical: 6.h),
          child: Center(
            child: CustomText(
              text: text,
              fontSize: fontSize ?? 14.sp,
              fontWeight: FontWeight.w500,
              color: textColor ?? AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
