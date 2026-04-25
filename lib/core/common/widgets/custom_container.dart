import 'package:flutter/material.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? color;
  final Gradient? gradient;
  final bool shadow;

  const CustomContainer({
    super.key,
    required this.child,
    this.margin,
    this.color,
    this.gradient,
    this.shadow = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin ?? EdgeInsets.symmetric(vertical: 10.h),
      padding: padding ?? EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        color: gradient == null ? (color ?? null) : null,
        gradient: gradient ?? (color == null ? AppColors.verseGradient : null),
        borderRadius: BorderRadius.circular(16.h),

        /// 🔥 Shadow condition
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: AppColors.black.withAlpha(10),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
