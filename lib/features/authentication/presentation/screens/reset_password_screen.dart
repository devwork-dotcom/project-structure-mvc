import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/custom_back_button.dart';
import 'package:project_structure/core/common/widgets/custom_text_box.dart';
import 'package:project_structure/core/common/widgets/loader.dart';
import 'package:project_structure/features/authentication/presentation/widgets/sign_up_confirmation_dialog.dart';
import 'package:project_structure/features/authentication/presentation/widgets/title_text.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/universal_Image.dart'
    show UniversalImage;
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizer.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../core/utils/validators/app_validator.dart';
import '../../controllers/reset_password_controller.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String token;
  ResetPasswordScreen({super.key, required this.token});

  final ResetPasswordController controller = Get.put(ResetPasswordController());
  //final SignUpController signController = Get.put(SignUpController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 26),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                CustomBackButton(),
                Gap(32.h),
                Center(
                  child: UniversalImage(
                    imagePath: IconPath.logo,
                    height: 72.h,
                    width: 100.h,
                    fit: BoxFit.cover,
                  ),
                ),
                TitleText(
                  title: "Create a New Password",
                  subTitle:
                      "Create a Strong New Password. Secure your account and keep moving",
                ),
                SizedBox(height: 24.h),
                Obx(() {
                  return CustomTextBox(
                    title: "Password",
                    hintText: 'Create password',
                    controller: controller.passwordTEController,
                    obscureText: controller.isPasswordVisible.value,
                    suffixIcon: GestureDetector(
                      onTap: () => controller.isPasswordVisible.value =
                          !controller.isPasswordVisible.value,
                      child: controller.isPasswordVisible.value
                          ? Icon(
                              Icons.visibility_off_outlined,
                              color: AppColors.textSecondary,
                            )
                          : Icon(
                              Icons.visibility_outlined,
                              color: AppColors.textSecondary,
                            ),
                    ),
                    validator: AppValidator.validatePassword,
                  );
                }),
                SizedBox(height: 8.h),

                Obx(() {
                  return CustomTextBox(
                    title: "Confirm Password",
                    hintText: 'Confirm Password',
                    controller: controller.confirmPasswordTEController,
                    obscureText: controller.isComPasswordVisible.value,
                    suffixIcon: GestureDetector(
                      onTap: () => controller.isComPasswordVisible.value =
                          !controller.isComPasswordVisible.value,
                      child: controller.isComPasswordVisible.value
                          ? Icon(
                              Icons.visibility_off_outlined,
                              color: AppColors.textSecondary,
                            )
                          : Icon(
                              Icons.visibility_outlined,
                              color: AppColors.textSecondary,
                            ),
                    ),
                  );
                }),
                Gap(32.h),
                Obx(
                  () => controller.isLoading.value
                      ? Loader()
                      : CustomButton(
                          text: 'Save & Continue',
                          onTap: () {
                            // if (_formKey.currentState!.validate()) {
                            //   controller.resetPassword(token: token);
                            // }
                            showSignupConfirmationDialog(
                              image: IconPath.success,
                              title: "Success",
                              subTitle: "You’re Back on Track  Your password has been updated",
                              butonText: "Go Login",
                              onTap: () {
                                Get.to(() => LoginScreen());
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
