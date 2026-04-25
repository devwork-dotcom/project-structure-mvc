import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:project_structure/core/common/widgets/container_shimmer.dart';
import 'package:project_structure/core/common/widgets/custom_appbar_widget.dart';
import 'package:project_structure/core/common/widgets/custom_container.dart';
import 'package:project_structure/core/common/widgets/custom_scaffold.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/common/widgets/custom_html_text.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import 'package:project_structure/features/profile/controller/privacy_controller.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PrivacyController privacyController = Get.put(PrivacyController());

    return CustomScaffold(
      appBar: CustomAppbarWidget(text: "Privacy Policy"),
      child: Obx(() {
        if (privacyController.isPrivacyLoading.value) {
          return ContainerShimmer(count: 20, height: 20.h, spacing: 12.h);
        }

        final privacyData = privacyController.privacyPolicyModel.value?.data;

        if (privacyData == null) {
          return Center(
            child: CustomText(
              text: "No privacy policy data available.",
              fontSize: 14.sp,
            ),
          );
        }

        final String formattedDate = privacyData.updatedAt != null
            ? DateFormat('MMMM d, yyyy').format(privacyData.updatedAt!)
            : 'N/A';

        return SingleChildScrollView(
          child: Column(
            children: [
              CustomContainer(
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 20.sp,
                      color: AppColors.primary,
                    ),
                    Gap(12.w),
                    CustomText(
                      text: "Last Updated: $formattedDate",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
              CustomContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Privacy Policy",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                    Gap(8.h),
                    CustomText(
                      text: "Effective Date: $formattedDate",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                    Gap(8.h),
                    CustomHtmlText(text: privacyData.content ?? ""),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
