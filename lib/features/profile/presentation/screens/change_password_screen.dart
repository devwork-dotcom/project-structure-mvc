import 'package:flutter/material.dart';
import 'package:project_structure/core/common/widgets/custom_appbar_widget.dart';
import 'package:project_structure/core/common/widgets/custom_container.dart';
import 'package:project_structure/core/common/widgets/custom_scaffold.dart';
import 'package:project_structure/core/common/widgets/custom_text_box.dart';
import 'package:project_structure/core/common/widgets/loader.dart';
import '../../../../core/utils/constants/app_sizer.dart';
import 'package:get/get.dart';

import '../../../../core/common/widgets/custom_button.dart';

import '../../../../core/common/widgets/custom_text.dart';

import '../../../../core/utils/constants/app_colors.dart';

import '../../../../core/utils/validators/app_validator.dart';
import '../../controller/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());
    return CustomScaffold(
      appBar: CustomAppbarWidget(text: "Change Password"),
      child: Form(
        key: _formKey,
        child: CustomContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                text: "Change password",
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
              SizedBox(height: 8.h),
              CustomText(
                text: "Change your password ",
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  spacing: 6,

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => CustomTextBox(
                        title: 'Current Password',
                        controller: controller.currentPasswordController,
                        hintText: 'Enter Current Password',
                        obscureText: !controller.isCurrentPasswordVisible.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isCurrentPasswordVisible.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: controller.toggleCurrentPasswordVisibility,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Obx(
                      () => CustomTextBox(
                        title: 'New Password',
                        controller: controller.newPasswordController,
                        hintText: 'Enter New Password',
                        obscureText: !controller.isNewPasswordVisible.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isNewPasswordVisible.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: controller.toggleNewPasswordVisibility,
                        ),
                        validator: AppValidator.validatePassword,
                      ),
                    ),

                    Obx(
                      () => CustomTextBox(
                        title: 'Confirm Password',
                        controller: controller.confirmPasswordController,
                        hintText: 'Enter Confirm Password',
                        obscureText: !controller.isConfirmPasswordVisible.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isConfirmPasswordVisible.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: controller.toggleConfirmPasswordVisibility,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please re-type password';
                          }
                          if (value !=
                              controller.newPasswordController.text.trim()) {
                            return 'Passwords do not match.';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 36.h),
                  ],
                ),
              ),
              Obx(
                () => controller.isChangePasswordLoading.value
                    ? Loader()
                    : CustomButton(
                        text: 'Change Password',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            controller.changePassword();
                          }
                        },
                      ),
              ),
              SizedBox(height: 36.h),
            ],
          ),
        ),
      ),
    );
  }
}
