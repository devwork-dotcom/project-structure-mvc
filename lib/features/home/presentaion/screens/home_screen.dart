import 'package:flutter/material.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/custom_profile_appbar_cart.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/common/widgets/empty_card.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import 'package:project_structure/core/utils/constants/icon_path.dart';
import 'package:project_structure/features/home/controllers/home_controller.dart';
import 'package:project_structure/features/notification/presentation/screen/notification_screen.dart';
import 'package:project_structure/features/profile/presentation/screens/profile_screen.dart';
import 'package:project_structure/features/profile/controller/profile_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (profileController.profileDataModel.value?.data == null) {
        await profileController.getProfileData(showLoader: true);
      }
      profileController.checkProfileCompletion();
    });

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.h),
        child: Obx(() {
          return CustomProfileAppbarCart(
            image: profileController.imageUrl.value.isEmpty
                ? IconPath.profile
                : profileController.imageUrl.value,
            name:
                profileController.profileDataModel.value?.data?.name ?? "User",
            isLoading: profileController.isLoading.value,
            notification: 1,
            onTabNotification: () {
              Get.to(() => NotificationScreens());
            },
            onProfileTap: () {
              Get.to(() => ProfileScreen());
            },
          );
        }),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [EmptyCard(title: "Homescreen")],
            ),
          ),
        ),
      ),
    );
  }
}
