import 'package:flutter/material.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

class TitleText extends StatelessWidget {
  final String title;
  final String subTitle;
  final String? emailText;

  const TitleText({
    super.key,
    required this.title,
    required this.subTitle,
    this.emailText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Title
          CustomText(
            text: title,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),

          SizedBox(height: 8.h),

          /// Subtitle + optional email
          Row(
            children: [
              Expanded(
                child: emailText == null
                    ? CustomText(
                        text: subTitle,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        textAlign: TextAlign.center,
                      )
                    : RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                          children: [
                            TextSpan(
                              text: subTitle,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const TextSpan(text: ' '),

                            TextSpan(
                              text: emailText,
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
