import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import 'package:project_structure/core/utils/constants/icon_path.dart';
import 'package:project_structure/features/onboarding/controller/onboarding_controller.dart';

class OnboardingDotIndicator extends StatelessWidget {
  const OnboardingDotIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();
    final List<String> indicatorSvgs = [
      IconPath.dot1,
      IconPath.dot2,
      IconPath.dot3,
    ];

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(indicatorSvgs.length, (index) {
          final bool isSelected = controller.selectedPageIndex.value == index;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            width: isSelected ? 20.w : 16.w,
            height: isSelected ? 20.w : 16.w,
            child: isSelected
                ? SvgPicture.asset(
                    indicatorSvgs[index],
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withAlpha(100),
                    ),
                  ),
          );
        }),
      ),
    );
  }
}
