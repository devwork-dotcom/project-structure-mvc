import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_structure/core/common/widgets/custom_appbar_widget.dart';
import 'package:project_structure/core/common/widgets/custom_scaffold.dart';
import 'package:project_structure/features/profile/controller/profile_controller.dart';
import 'package:project_structure/features/profile/presentation/screens/change_password_screen.dart';
import 'package:project_structure/features/profile/presentation/screens/edit_personal_info_screen.dart';
import 'package:project_structure/features/profile/presentation/widgets/edit_profile_card.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return CustomScaffold(
      appBar: CustomAppbarWidget(text: "Edit Profile"),
      child: Column(
        children: [
          EditProfileCard(
            networkImageUrl: controller.imageUrl.value,
            onImageTap: () {
              controller.pickImage(ImageSource.gallery);
            },
            onSaveTap: () {
              controller.updateAccount();
            },
            onChangePasswordTap: () {
              Get.to(() => ChangePasswordScreen());
            },
            onPersonalInfoTap: () {
              Get.to(() => EditPersonalInfoScreen());
            },
          ),
        ],
      ),
    );
  }
}
