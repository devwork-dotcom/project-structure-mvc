import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/custom_container.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import 'package:project_structure/features/profile/model/faq_model.dart';

class FaqSection extends StatelessWidget {
  final String title;
  final List<dynamic> items;

  const FaqSection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final RxInt expandedIndex = (-1).obs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 Title
        CustomText(
          text: title,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),

        SizedBox(height: 16.h),

        Obx(
          () => Column(
            children: List.generate(items.length, (index) {
              final isExpanded = expandedIndex.value == index;

              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      expandedIndex.value = isExpanded ? -1 : index;
                    },
                    child: CustomContainer(
                      margin: EdgeInsets.only(bottom: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Question Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomText(
                                  text: items[index].question,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                              ),
                              Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: AppColors.textSecondary,
                              ),
                            ],
                          ),

                          if (isExpanded) ...[
                            SizedBox(height: 12.h),
                            CustomText(
                              text: items[index].answer,
                              fontSize: 13.sp,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
