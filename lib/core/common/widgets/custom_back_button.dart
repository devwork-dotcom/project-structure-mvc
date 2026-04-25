import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

class CustomBackButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final VoidCallback? onTap;

  const CustomBackButton({
    super.key,
    this.height,
    this.width,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Get.back(),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: color ?? AppColors.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: Icon(
              Icons.arrow_back,
              color: AppColors.primary,
              size: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
