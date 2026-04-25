import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:project_structure/core/common/widgets/custom_back_button.dart';
import 'package:project_structure/core/common/widgets/loader.dart';
import 'package:project_structure/core/common/widgets/universal_Image.dart';
import 'package:project_structure/core/utils/constants/enums.dart';
import 'package:project_structure/core/utils/constants/icon_path.dart';
import 'package:project_structure/features/authentication/presentation/widgets/sign_up_confirmation_dialog.dart';
import 'package:project_structure/features/authentication/presentation/widgets/title_text.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizer.dart';
import '../../controllers/verify_controller.dart';
import 'login_screen.dart';
import 'reset_password_screen.dart';

class VerifyCodeScreen extends StatelessWidget {
  final String email;
  final String verifyType;
  VerifyCodeScreen({super.key, required this.email, required this.verifyType});

  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Stack(
            children: [
              Positioned(top: 0, left: 0, child: CustomBackButton()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UniversalImage(
                    imagePath: IconPath.logo,
                    height: 72.h,
                    width: 100.h,
                    fit: BoxFit.cover,
                  ),
                  TitleText(
                    title: "Verify Your Code",
                    subTitle: "We’ve sent a secure code to your email",
                    emailText: email,
                  ),
                  SizedBox(height: 32.h),

                  Center(
                    child: Pinput(
                      length: 6,
                      controller: controller.otpTEController,
                      focusNode: controller.focusNode,

                      defaultPinTheme: PinTheme(
                        width: 52.w,
                        height: 52.h,
                        textStyle: TextStyle(
                          fontSize: 24.sp,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(50.w),
                          border: Border.all(
                            color: AppColors.containerBorder,
                            width: 1.w,
                          ),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 52.w,
                        height: 52.h,
                        textStyle: TextStyle(
                          fontSize: 24.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(
                            color: AppColors.primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(50.w),
                        ),
                      ),
                      submittedPinTheme: PinTheme(
                        width: 52.w,
                        height: 52.h,
                        textStyle: TextStyle(
                          fontSize: 24.sp,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(30),
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(50.w),
                        ),
                      ),
                      // onCompleted: (pin) {
                      //   controller.verifyOtp(pin);
                      // },
                      onChanged: controller.updateOtpValue,
                    ),
                  ),

                  SizedBox(height: 34.h),
                  // Verify Button with Loading
                  Obx(
                    () => controller.isLoading.value
                        ? Loader()
                        : CustomButton(
                            text: 'Verify Code',
                            onTap: () {
                              // controller.verifyOtp(
                              //   otp: controller.otpTEController.text.trim(),
                              //   email: email,
                              //   verifyType: verifyType,
                              // );

                              if (verifyType == VerifyType.SIGNUP.name) {
                                Future.delayed(const Duration(milliseconds: 800), () {
                                  showSignupConfirmationDialog(
                                    image: IconPath.success,
                                    title: 'Success',
                                    subTitle: 'Your account is successfully created.',
                                    butonText: 'Go Login',
                                    onTap: () {
                                      Get.offAll(() => LoginScreen());
                                    },
                                  );
                                });
                              }
                              else if (verifyType == VerifyType.FORGET.name) {
                                Get.off(() => ResetPasswordScreen(token: "testing token"));
                              }
                            },
                          ),
                  ),
                  SizedBox(height: 34.h),

                  // Resend Timer & Button
                  Obx(
                    () => Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: controller.isResendClickable.value
                                ? "Didn't receive code? "
                                : "Resend code in ",
                            fontSize: 16.sp,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w400,
                          ),
                          if (!controller.isResendClickable.value)
                            CustomText(
                              text: controller.countdownText,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          if (controller.isResendClickable.value)
                            GestureDetector(
                              onTap: () {
                                //controller.resendOtp(email: email);
                              },
                              child: controller.isResentPasswordLoading.value
                                  ? Loader()
                                  : CustomText(
                                      text: 'Resend',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
