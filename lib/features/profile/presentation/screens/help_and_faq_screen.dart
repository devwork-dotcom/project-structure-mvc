import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/container_shimmer.dart';
import 'package:project_structure/core/common/widgets/custom_appbar_widget.dart';
import 'package:project_structure/core/common/widgets/custom_scaffold.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/common/widgets/empty_card.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import 'package:project_structure/features/profile/controller/privacy_controller.dart';
import 'package:project_structure/features/profile/model/faq_model.dart';
import 'package:project_structure/features/profile/presentation/widgets/faq_section.dart';

class HelpAndFaqScreen extends StatelessWidget {
  const HelpAndFaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrivacyController());

    return CustomScaffold(
      appBar: const CustomAppbarWidget(text: "Help & FAQs"),
      child: Obx(() {
        if (controller.isFaqLoading.value) {
          return ContainerShimmer(height: 60.h, count: 12);
        }

        final faqData = controller.faqModel.value?.data;

        if (faqData == null || faqData.isEmpty) {
          return EmptyCard();
        }

        // Grouping by category
        final Map<String, List<Datum>> groupedFaqs = {};
        for (var faq in faqData) {
          final category = faq.category ?? "General Questions";
          if (!groupedFaqs.containsKey(category)) {
            groupedFaqs[category] = [];
          }
          groupedFaqs[category]!.add(faq);
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Frequently Asked Questions",
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
                color: AppColors.primary,
              ),
              Gap(10.h),

              ...groupedFaqs.entries.map((entry) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: FaqSection(title: entry.key, items: entry.value),
                );
              }).toList(),
            ],
          ),
        );
      }),
    );
  }
}
