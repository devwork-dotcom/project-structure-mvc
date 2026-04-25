import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/custom_appbar_widget.dart';
import 'package:project_structure/core/common/widgets/custom_button.dart';
import 'package:project_structure/core/common/widgets/custom_dropdown.dart';
import 'package:project_structure/core/common/widgets/custom_scaffold.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/common/widgets/custom_text_field.dart';
import 'package:project_structure/core/common/widgets/loader.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import 'package:project_structure/features/authentication/controllers/profile_information_controller.dart';
import 'package:gap/gap.dart';

class EditPersonalInfoScreen extends StatelessWidget {
  const EditPersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileInformationController());

    return CustomScaffold(
      appBar: CustomAppbarWidget(
        text: "Edit Profile Information",
        onBackTab: controller.clearField,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CustomText(
              text: "Tell us about yourself",
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          Gap(8.h),
          Center(
            child: CustomText(
              text:
                  "This information helps us personalize your health plan and calculate your daily nutrition targets.",
              fontSize: 14.sp,
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
            ),
          ),
          Gap(32.h),

          // Age
          _label("Age"),
          SizedBox(
            width: 150.h,
            child: CustomTextField(
              controller: controller.ageController,
              hintText: "Age",
              keyboardType: TextInputType.number,
              prefixIconPath: Icon(
                Icons.calendar_today_outlined,
                size: 20.sp,
                color: AppColors.primary,
              ),
            ),
          ),
          Gap(20.h),

          // Height
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label("Height (cm)"),
                    CustomTextField(
                      controller: controller.heightController,
                      hintText: "Height",
                      keyboardType: TextInputType.number,
                      prefixIconPath: Icon(
                        Icons.height_outlined,
                        size: 20.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(20.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label("Weight (kg)"),
                    CustomTextField(
                      controller: controller.weightController,
                      hintText: "Weight",
                      keyboardType: TextInputType.number,
                      prefixIconPath: Icon(
                        Icons.monitor_weight_outlined,
                        size: 20.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Gap(20.h),

          // Gender
          _label("Gender"),
          Obx(
            () => CustomDropdownField(
              hintText: "Select gender",
              items: controller.genderItems,
              selectedValue: controller.selectedGender.value,
              onChanged: (val) => controller.selectedGender.value = val,
              borderColor: AppColors.containerBorder,
              borderRadius: 12,
            ),
          ),
          Gap(20.h),

          // Activity Level
          _label("Activity Level"),
          Obx(
            () => CustomDropdownField(
              hintText: "Select activity level",
              items: controller.activityLevels,
              selectedValue: controller.selectedActivityLevel.value,
              onChanged: (val) => controller.selectedActivityLevel.value = val,
              borderColor: AppColors.containerBorder,
              borderRadius: 12,
            ),
          ),
          Gap(20.h),

          // Goal
          _label("Your Goal"),
          Obx(
            () => CustomDropdownField(
              hintText: "Select goal",
              items: controller.goalItems,
              selectedValue: controller.selectedGoal.value,
              onChanged: (val) => controller.selectedGoal.value = val,
              borderColor: AppColors.containerBorder,
              borderRadius: 12,
            ),
          ),
          Gap(40.h),

          // Submit Button
          Obx(
            () => controller.isLoading.value
                ? Loader()
                : CustomButton(
                    text: "Save Profile",
                    onTap: () => controller.submitProfile(getBack: true),
                  ),
          ),
          Gap(20.h),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: CustomText(
        text: text,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }
}
