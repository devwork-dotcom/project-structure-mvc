import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_structure/core/common/widgets/auth_divider.dart';
import 'package:project_structure/core/common/widgets/custom_text_box.dart';
import 'package:project_structure/core/common/widgets/loader.dart';
import 'package:project_structure/core/common/widgets/universal_Image.dart';
import 'package:project_structure/core/utils/constants/enums.dart';
import 'package:project_structure/features/authentication/presentation/screens/login_screen.dart';
import 'package:project_structure/features/authentication/presentation/screens/verify_code_screen.dart';
import 'package:project_structure/features/authentication/presentation/widgets/social_card_widget.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizer.dart';
import '../../../../core/utils/constants/icon_path.dart';
import 'package:get/get.dart';
import '../../../../core/utils/validators/app_validator.dart';
import '../../controllers/sing_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpController controller = Get.put(SignUpController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 26.h),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UniversalImage(
                    imagePath: IconPath.logo,
                    height: 72.h,
                    width: 100.h,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 32.h),

                  CustomText(
                    text: 'Create Your Account',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  SizedBox(height: 8.h),
                  CustomText(
                    text: 'Start your wellness journey today.',
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                  SizedBox(height: 32.h),
                  CustomTextBox(
                    title: "Full Name",
                    hintText: "Enter your name",
                    controller: controller.nameTEController,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextBox(
                    controller: controller.emailTEController,
                    title: "Email Address",
                    hintText: "your@email.com",
                    validator: (value) => AppValidator.validateEmail(value),
                  ),
                  SizedBox(height: 16.h),
                  Obx(
                    () => CustomTextBox(
                      title: "Password",
                      hintText: "Create Password",
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
                    ),
                  ),
                  SizedBox(height: 16.h),

                  Obx(
                    () => CustomTextBox(
                      title: "Confirm Password",
                      hintText: "Confirm Password",
                      controller: controller.confirmPasswordTEController,
                      obscureText: controller.isConfirmPasswordVisible.value,
                      suffixIcon: GestureDetector(
                        onTap: () => controller.isConfirmPasswordVisible.value =
                            !controller.isConfirmPasswordVisible.value,
                        child: controller.isConfirmPasswordVisible.value
                            ? Icon(
                                Icons.visibility_off_outlined,
                                color: AppColors.textSecondary,
                              )
                            : Icon(
                                Icons.visibility_outlined,
                                color: AppColors.textSecondary,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),

                  ///Terms and Services
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Checkbox (aligned with text)
                      Obx(
                        () => Transform.translate(
                          offset: Offset(0, -6.h),
                          child: Checkbox(
                            value: controller.isAgree.value,
                            onChanged: (value) {
                              controller.isAgree.value = value ?? false;
                            },
                            activeColor: AppColors.primary,
                            checkColor: AppColors.white,
                            side: BorderSide(
                              color: AppColors.textSecondary,
                              width: 1.5,
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                      ),

                      SizedBox(width: 4.w),

                      /// Text with clickable spans
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                              height: 1.4,
                            ),
                            children: [
                              const TextSpan(text: 'I agree to '),
                              TextSpan(
                                text: 'Terms of Services',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // navigate to terms
                                  },
                              ),
                              const TextSpan(text: ' & '),
                              TextSpan(
                                text: 'Privacy Policy.',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // navigate to privacy
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 32.h),
                  Obx(
                    () => controller.isLoading.value
                        ? Loader()
                        : CustomButton(
                            text: 'Sign Up',
                            onTap: () {
                              // if (_formKey.currentState!.validate()) {
                              //   controller.signUp(
                              //     email: controller.emailTEController.text
                              //         .trim(),
                              //     verifyType: VerifyType.SIGNUP.name,
                              //   );
                              // }
                              Get.to(()=>VerifyCodeScreen(email: "example@mailto.plus", verifyType: VerifyType.SIGNUP.name));
                            },
                          ),
                  ),
                  SizedBox(height: 32.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Already have an account?',
                        color: AppColors.textSecondary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => LoginScreen());
                        },
                        child: CustomText(
                          text: ' Login',
                          color: AppColors.textPrimary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  const AuthDivider(animationIndex: 4, text: "Or Sign In with"),
                  SizedBox(height: 32.h),
                  SocialCardWidget(),
                  SizedBox(height: 18.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
