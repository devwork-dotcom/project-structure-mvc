import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/cached_image.dart';
import 'package:project_structure/core/common/widgets/custom_container.dart';
import 'package:project_structure/core/common/widgets/custom_button.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/common/widgets/custom_text_field.dart';
import 'package:project_structure/core/common/widgets/loader.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import 'package:project_structure/features/profile/controller/profile_controller.dart';

class EditProfileCard extends StatelessWidget {
  final String? networkImageUrl;
  final VoidCallback onImageTap;
  final VoidCallback onSaveTap;
  final VoidCallback onChangePasswordTap;
  final VoidCallback onPersonalInfoTap;

  const EditProfileCard({
    super.key,
    required this.networkImageUrl,
    required this.onImageTap,
    required this.onSaveTap,
    required this.onChangePasswordTap,
    required this.onPersonalInfoTap,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Column(
      children: [
        /// 🔹 Profile Edit Card
        CustomContainer(
          color: AppColors.white,
          child: Column(
            children: [
              /// Profile Image
              Obx(() {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 45.h,
                      backgroundColor: AppColors.containerSoft,
                      child: ClipOval(
                        child: controller.profileImage.value != null
                            ? Image.file(
                                controller.profileImage.value!,
                                width: 90.h,
                                height: 90.h,
                                fit: BoxFit.cover,
                              )
                            : (networkImageUrl != null &&
                                      networkImageUrl!.isNotEmpty
                                  ? CachedImage(
                                      imagePath: networkImageUrl!,
                                      width: 90.h,
                                      height: 90.h,
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.person,
                                      size: 40.sp,
                                      color: AppColors.textSecondary,
                                    )),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: onImageTap,
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 16.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),

              SizedBox(height: 24.h),

              /// Full Name Label
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "Full Name",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),

              SizedBox(height: 8.h),

              /// Name Field
              CustomTextField(
                controller: controller.nameController,
                hintText: "Enter your name",
                borderColor: AppColors.containerBorder,
              ),

              SizedBox(height: 20.h),

              /// Save Button
              Obx(
                () => controller.isProfileUpdateLoading.value
                    ? Loader()
                    : CustomButton(
                        text: "Save",
                        onTap: onSaveTap,
                        height: 44.h,
                        borderRadius: BorderRadius.circular(12.h),
                        backgroundColor: AppColors.primary,
                      ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20.h),

        /// 🔹 Change Personal Info Card
        CustomContainer(
          color: AppColors.white,
          child: InkWell(
            onTap: onPersonalInfoTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Edit Personal Info",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
                Icon(
                  Icons.chevron_right,
                  size: 22.sp,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),

        /// 🔹 Change Password Card
        CustomContainer(
          color: AppColors.white,
          child: InkWell(
            onTap: onChangePasswordTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Change Password",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
                Icon(
                  Icons.chevron_right,
                  size: 22.sp,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
