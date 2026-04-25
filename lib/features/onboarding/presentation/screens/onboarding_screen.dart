import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/custom_button.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import 'package:project_structure/core/utils/constants/icon_path.dart';
import '../../controller/onboarding_controller.dart';
import '../widgets/onboarding_dot_indicator.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.updatePageIndicator,
                children: const [
                  OnboardingPage(
                    image: IconPath.onboarding1,
                    title: "Renew Your Mind",
                    subtitle: "Start each day with scripture and reflection.",
                  ),
                  OnboardingPage(
                    image: IconPath.onboarding2,
                    title: "Nourish Your Body",
                    subtitle:
                        "Track meals, water intake, and build healthy habits.",
                  ),
                  OnboardingPage(
                    image: IconPath.onboarding3,
                    title: "Move with Purpose",
                    subtitle: "Log workouts, track progress, stay consistent.",
                  ),
                ],
              ),
            ),
            const OnboardingDotIndicator(),
            Gap(40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Obx(
                () => CustomButton(
                  onTap: () => controller.nextPage(),
                  text: controller.isLastPage ? "Get Started" : "Next",
                ),
              ),
            ),
            Gap(56.h),
          ],
        ),
      ),
    );
  }
}
