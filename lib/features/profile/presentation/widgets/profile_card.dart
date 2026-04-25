import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/cached_image.dart';
import 'package:project_structure/core/common/widgets/customContainer_button.dart';
import 'package:project_structure/core/common/widgets/custom_container.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/common/widgets/universal_Image.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import 'package:project_structure/features/profile/controller/profile_controller.dart';

class ProfileCard extends StatelessWidget {
  final String? networkImageUrl;
  final String name;
  final String email;
  final VoidCallback imageUploadTap;
  final VoidCallback onEditTap;

  const ProfileCard({
    super.key,
    required this.networkImageUrl,
    required this.name,
    required this.email,
    required this.imageUploadTap,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return CustomContainer(
      color: AppColors.white,
      child: Row(
        children: [
          Obx(() {
            final hasLocalImage = controller.profileImage.value != null;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 40.h,
                  backgroundColor: AppColors.white,
                  child: ClipOval(
                    child: hasLocalImage
                        ? Image.file(
                            controller.profileImage.value!,
                            width: 80.h,
                            height: 80.h,
                            fit: BoxFit.cover,
                          )
                        : CachedImage(
                            imagePath: networkImageUrl ?? "",
                            width: 80.h,
                            height: 80.h,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),

                /// Camera Icon
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: InkWell(
                    onTap: imageUploadTap,
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

          SizedBox(width: 16.w),

          /// 🔹 Name & Email
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),

                SizedBox(height: 6.h),

                CustomText(
                  text: email,
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                ),

                SizedBox(height: 14.h),

                SizedBox(
                  width: 120.w,
                  child: CustomContainerButton(
                    onTap: onEditTap,
                    text: "Edit Profile",
                    borderRadius: 12.h,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
