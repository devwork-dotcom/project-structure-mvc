import 'package:flutter/material.dart';
import 'package:project_structure/core/common/widgets/custom_text_box.dart';
import 'package:project_structure/core/common/widgets/loader.dart';
import 'package:project_structure/core/common/widgets/universal_Image.dart';
import 'package:project_structure/features/authentication/presentation/screens/sing_up_screen.dart';
import 'package:project_structure/features/authentication/presentation/widgets/social_card_widget.dart';
import 'package:project_structure/features/nav_bar/presentation/screens/nav_bar.dart';
import '../../../../core/common/widgets/auth_divider.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text.dart';
import 'package:get/get.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizer.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../core/utils/validators/app_validator.dart';
import '../../../../routes/app_routes.dart';
import '../../controllers/login_controller.dart';
import '../../controllers/social_auth_login.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());
  final SocialAuthController socialAuthController = Get.put(
    SocialAuthController(),
  );
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 26),
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
                    text: 'Welcome Back',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  SizedBox(height: 8.h),
                  CustomText(
                    text: 'Sign in to continue your journey',
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                  SizedBox(height: 32.h),
                  CustomTextBox(
                    controller: controller.emailController,
                    title: "Email Address",
                    hintText: "your@email.com",
                    validator: (value) => AppValidator.validateEmail(value),
                  ),
                  SizedBox(height: 16.h),
                  Obx(
                    () => CustomTextBox(
                      title: "Password",
                      hintText: "Create Password",
                      controller: controller.passwordText,
                      obscureText: controller.isPasswordHidden.value,
                      suffixIcon: GestureDetector(
                        onTap: () => controller.isPasswordHidden.value =
                            !controller.isPasswordHidden.value,
                        child: controller.isPasswordHidden.value
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
                  SizedBox(height: 8.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Remember Me
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            controller.toggleRememberMe(
                              !controller.rememberMe.value,
                            );
                          },
                          child: Row(
                            children: [
                              Checkbox(
                                value: controller.rememberMe.value,
                                onChanged: (value) {
                                  controller.toggleRememberMe(value);
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
                              CustomText(
                                text: 'Remember me',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// Forgot Password
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoute.emailVerifyScreen);
                        },
                        child: CustomText(
                          text: 'Forgot Password?',
                          color: AppColors.error,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 32.h),
                  Obx(
                    () => controller.isLoading.value
                        ? Loader()
                        : CustomButton(
                            text: "Log In",
                            onTap: () {
                              // if (_formKey.currentState!.validate()) {
                              //   controller.signIn();
                              // }
                              Get.to(()=>NavBar());
                            },
                          ),
                  ),

                  SizedBox(height: 32.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Doesn’t have account?',
                        color: AppColors.textSecondary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => SignUpScreen());
                        },
                        child: CustomText(
                          text: ' Sign Up',
                          color: AppColors.textPrimary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  const AuthDivider(animationIndex: 4),
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
