import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/custom_back_button.dart';
import 'package:project_structure/core/common/widgets/custom_text_box.dart';
import 'package:project_structure/core/common/widgets/loader.dart';
import 'package:project_structure/core/common/widgets/universal_Image.dart';
import 'package:project_structure/core/utils/constants/enums.dart';
import 'package:project_structure/core/utils/constants/icon_path.dart';
import 'package:project_structure/features/authentication/presentation/screens/verify_code_screen.dart';
import 'package:project_structure/features/authentication/presentation/widgets/title_text.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizer.dart';
import '../../controllers/forget_pass_controller.dart';

class EmailVerifyScreen extends StatelessWidget {
  EmailVerifyScreen({super.key});

  final ForgetPasswordController controller = Get.put(
    ForgetPasswordController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomBackButton(),
              Gap(32.h),
              Center(
                child: Container(
                  padding: EdgeInsets.all(8.h),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                  child: UniversalImage(
                    imagePath: IconPath.logo,
                    height: 72.h,
                    width: 100.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              TitleText(
                title: "Forgot Password",
                subTitle: "Let’s get you back in",
              ),
              SizedBox(height: 16.h),
              CustomTextBox(
                title: 'Email Address',
                hintText: "your@email.com",
                controller: controller.emailTextEditingController,
              ),
              SizedBox(height: 32.h),
              Obx(
                () => controller.isLoading.value
                    ? Loader()
                    : CustomButton(
                        text: 'Send Code',
                        onTap: () {
                          // controller.forgetPassword(
                          //   email: controller.emailTextEditingController.text
                          //       .trim(),
                          //   verifyType: VerifyType.FORGET.name,
                          // );
                          Get.to(()=>VerifyCodeScreen(email: "example@mailto.plus", verifyType: VerifyType.FORGET.name));
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
