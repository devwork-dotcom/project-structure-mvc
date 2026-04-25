import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_structure/core/common/widgets/container_shimmer.dart';
import 'package:project_structure/core/common/widgets/custom_appbar_widget.dart';
import 'package:project_structure/core/common/widgets/custom_container.dart';
import 'package:project_structure/core/common/widgets/custom_scaffold.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/common/widgets/custom_html_text.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import 'package:project_structure/features/profile/controller/privacy_controller.dart';

class TermsOfServicesScreen extends StatelessWidget {
  const TermsOfServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PrivacyController privacyController = Get.put(PrivacyController());

    return CustomScaffold(
      appBar: CustomAppbarWidget(text: "Terms of Service"),
      child: Obx(() {
        if (privacyController.isTermsLoading.value) {
          return ContainerShimmer(count: 20, height: 20.h, spacing: 12.h);
        }

        final termsData = privacyController.termConditionModel.value?.data;

        if (termsData == null) {
          return Center(
            child: CustomText(
              text: "No terms of service data available.",
              fontSize: 14.sp,
            ),
          );
        }

        final String formattedDate = termsData.updatedAt != null
            ? DateFormat('MMMM d, yyyy').format(termsData.updatedAt!)
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
                      text: "Terms of Service",
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
                    CustomHtmlText(text: termsData.content ?? ""),
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
