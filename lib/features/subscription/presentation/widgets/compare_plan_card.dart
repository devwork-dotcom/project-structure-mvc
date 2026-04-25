import 'package:flutter/material.dart';
import 'package:project_structure/core/common/widgets/custom_container.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

class ComparePlansCard extends StatelessWidget {
  const ComparePlansCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 🔹 Title
        CustomText(
          text: "Compare Plans",
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),

        /// 🔹 Table Container
        CustomContainer(
          child: Column(
            children: [
              /// Header Row
              _buildHeaderRow(),

              Divider(height: 24.h),

              /// Rows
              _buildRow("Workout logging", true, true),
              _buildRow("Basic meal tracking", true, true),
              _buildRow("Devotionals", true, true),
              _buildRow("Meal card library", false, true),
              _buildRow("Meal plans", false, true),
              _buildRow("Grocery lists", false, true),
              _buildRow("Progress tracking", false, true),
              _buildRow("Workout library", false, true),
              _buildRow("Priority support", false, true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: CustomText(
            text: "Feature",
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: CustomText(
              text: "Free",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: CustomText(
              text: "Premium",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String title, bool free, bool premium) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: CustomText(
                  text: title,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Icon(
                    free ? Icons.check : Icons.close,
                    color: free ? AppColors.success : AppColors.textSecondary,
                    size: 18.sp,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Icon(
                    premium ? Icons.check : Icons.close,
                    color: premium
                        ? AppColors.success
                        : AppColors.textSecondary,
                    size: 18.sp,
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 20.h, color: AppColors.containerBorder),
        ],
      ),
    );
  }
}
