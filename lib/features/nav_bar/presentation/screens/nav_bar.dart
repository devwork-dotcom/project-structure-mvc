import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/constants/app_sizer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../controllers/nav_bar_controller.dart';

class NavBar extends GetView<NavBarController> {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      extendBody: true,

      body: Obx(() => controller.screens[controller.currentIndex]),

      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 2.h),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(50.h),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withAlpha(20),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Obx(
              () => BottomNavigationBar(
                currentIndex: controller.currentIndex,
                onTap: controller.changeIndex,

                backgroundColor: AppColors.white.withAlpha(0),
                elevation: 0,
                type: BottomNavigationBarType.fixed,

                selectedItemColor: _getActiveColor(controller.currentIndex),
                unselectedItemColor: AppColors.textSecondary,

                selectedLabelStyle: GoogleFonts.poppins(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: _getActiveColor(controller.currentIndex),
                ),
                unselectedLabelStyle: GoogleFonts.poppins(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),

                showSelectedLabels: true,
                showUnselectedLabels: true,

                items: [
                  _buildNavItem(iconPath: IconPath.home, label: 'Home'),
                  _buildNavItem(iconPath: IconPath.home, label: 'Mindset'),
                  _buildNavItem(iconPath: IconPath.home, label: 'Hydration'),
                  _buildNavItem(iconPath: IconPath.home, label: 'Nutrition'),
                  _buildNavItem(iconPath: IconPath.home, label: 'Profile'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required String iconPath,
    required String label,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: SvgPicture.asset(
        iconPath,
        width: 20.h,
        height: 20.h,
        colorFilter: ColorFilter.mode(AppColors.textSecondary, BlendMode.srcIn),
      ),
      activeIcon: SvgPicture.asset(
        iconPath,
        width: 20.h,
        height: 20.h,
        colorFilter: ColorFilter.mode(
          _getActiveColor(controller.currentIndex),
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Color _getActiveColor(int index) {
    switch (index) {
      case 0: // Home
        return AppColors.primary;
      case 1: // Mindset
        return AppColors.primary;
      case 2: // Hydration
        return AppColors.info;
      case 3: // Nutrition
        return AppColors.warning;
      case 4: // Fitness
        return AppColors.success;
      default:
        return AppColors.primary;
    }
  }
}
