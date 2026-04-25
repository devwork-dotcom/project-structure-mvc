import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:project_structure/core/common/widgets/custom_appbar_widget.dart';
import 'package:project_structure/core/common/widgets/custom_scaffold.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/services/auth_service.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import 'package:project_structure/core/utils/constants/icon_path.dart';
import 'package:project_structure/features/profile/presentation/screens/contact_and_support.dart';
import 'package:project_structure/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:project_structure/features/profile/presentation/screens/help_and_faq_screen.dart';
import 'package:project_structure/features/profile/presentation/screens/privacy_policy_screen.dart';
import 'package:project_structure/features/profile/presentation/screens/terms_of_services_screen.dart';
import 'package:project_structure/features/profile/presentation/widgets/account_action_card.dart';
import 'package:project_structure/features/profile/presentation/widgets/notification_reminder_card.dart';
import 'package:project_structure/features/profile/presentation/widgets/profile_card.dart';
import 'package:get/get.dart';
import 'package:project_structure/features/profile/presentation/widgets/support_legal_card.dart';
import '../../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return CustomScaffold(
      appBar: CustomAppbarWidget(text: "Profile & Settings"),
      child: Column(
        children: [
          Obx(() {
            final data = controller.profileDataModel.value?.data;
            if (controller.isLoading.value) {
              return Shimmer.fromColors(
                baseColor: AppColors.containerBorder,
                highlightColor: AppColors.containerSoft,
                child: ProfileCard(
                  networkImageUrl: IconPath.profile,
                  name: "Loading...",
                  email: "Loading...",
                  imageUploadTap: () {},
                  onEditTap: () {},
                ),
              );
            }

            return ProfileCard(
              networkImageUrl: data?.profileImage ?? IconPath.profile,
              name: data?.name ?? "No Name",
              email: data?.email ?? "No Email",
              imageUploadTap: () {
                controller.pickImage(ImageSource.gallery);
              },
              onEditTap: () {
                Get.to(() => EditProfileScreen());
              },
            );
          }),



          NotificationReminderCard(),

          SupportLegalCard(
            onHelpTap: () {
              Get.to(() => HelpAndFaqScreen());
            },
            onContactTap: () {
              Get.to(() => ContactAndSupport());
            },
            onPrivacyTap: () {
              Get.to(() => PrivacyPolicyScreen());
            },
            onTermsTap: () {
              Get.to(() => TermsOfServicesScreen());
            },
          ),

          AccountActionsCard(
            onLogoutTap: () {
              AuthService.logoutUser();
            },
            onDeleteTap: () {},
          ),

          SizedBox(height: 10.h),

          CustomText(
            text: "App version v1.0.0",
            fontWeight: FontWeight.w400,
            color: AppColors.primary,
            fontSize: 14.sp,
          ),
        ],
      ),
    );
  }

  void showImageSourceDialog(BuildContext context) {
    final controller = Get.find<ProfileController>();
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo),
              title: Text("Gallery"),
              onTap: () {
                controller.pickImage(ImageSource.gallery);
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Camera"),
              onTap: () {
                controller.pickImage(ImageSource.camera);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
