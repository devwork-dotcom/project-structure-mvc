import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:project_structure/core/common/widgets/custom_appbar_widget.dart';
import 'package:project_structure/core/common/widgets/custom_button.dart';
import 'package:project_structure/core/common/widgets/custom_dropdown.dart';
import 'package:project_structure/core/common/widgets/custom_scaffold.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/common/widgets/custom_text_box.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import 'package:project_structure/core/utils/constants/information_list.dart';
import 'package:project_structure/features/profile/controller/contact_and_support_controller.dart';
import 'package:project_structure/features/profile/presentation/widgets/attachment_screenshot_card.dart';
import 'package:project_structure/features/profile/presentation/widgets/help_support_card.dart';

class ContactAndSupport extends StatelessWidget {
  const ContactAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContactAndSupportController());
    return CustomScaffold(
      appBar: CustomAppbarWidget(text: "Contact Support"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HelpSupportCard(
            onTap: () {
              log("Help tapped");
            },
          ),

          CustomTextBox(
            title: "Your Name",
            hintText: "Enter name",
            controller: controller.nameTEController,
          ),
          Gap(16.h),
          CustomTextBox(
            title: "Email Address",
            hintText: "example@email.com",
            controller: controller.emailTEController,
          ),
          Gap(6.h),
          CustomText(
            text: "We'll send our response to this email",
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
          Gap(16.h),
          CustomText(
            text: "What do you need help with?",
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
          Gap(8.h),
          Obx(
            () => CustomDropdownField(
              hintText: "Select a category",
              items: InformationList.categories,
              selectedValue: controller.selectedCategory.value,
              onChanged: controller.changeCategory,
            ),
          ),
          Gap(16.h),

          CustomTextBox(
            title: "Tell us more",
            hintText: "Write...",
            controller: controller.emailTEController,
            maxLines: 6,
            characterShow: true,
            maxLength: 1000,
          ),
          Gap(16.h),
          AttachScreenshotCard(),

          Gap(16.h),
          CustomButton(text: "Send Message", onTap: () {}),
          Gap(16.h),
        ],
      ),
    );
  }
}
