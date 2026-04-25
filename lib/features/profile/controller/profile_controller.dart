import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:project_structure/core/common/widgets/app_snackber.dart';

import '../../../core/common/widgets/app_toast.dart';

import '../../../core/common/widgets/loading_widgets.dart';
import 'package:project_structure/core/services/auth_service.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/app_urls.dart';
import '../../../core/utils/logging/logger.dart';
import '../model/profile_model.dart';
import 'package:dio/dio.dart' as dio;
import '../presentation/screens/edit_personal_info_screen.dart';

class ProfileController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final inProgress = false.obs;
  RxString imagePath = ''.obs;
  final RxString imageUrl = ''.obs;
  final Rx<File?> profileImage = Rx<File?>(null);
  final RxBool isNotificationEnabled = true.obs;

  // Image picker instance
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    //getProfileData(showLoader: true);
  }

  /// Method to pick an image from gallery or camera
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
        imagePath.value = pickedFile.path;
        await updateAccount();
      }
    } catch (e) {
      AppSnackBar.error("Failed to pick image");
      AppLoggerHelper.error('Error', 'Failed to pick image: $e');
    }
  }

  RxBool isPreferredUnits = false.obs;
  void togglePreferredUnit(bool value) {
    isPreferredUnits.value = value;
  }

  RxBool isPushNotificationReminderOn = false.obs;
  void toggleNotificationReminder(bool value) {
    isPushNotificationReminderOn.value = value;
  }

  /// Get Profile Data
  final RxBool isLoading = false.obs;
  final Rxn profileDataModel = Rxn<ProfileModel>();
  Future<void> getProfileData({bool showLoader = false}) async {
    if (showLoader) {
      isLoading.value = true;
    }

    try {
      // Ensure we have a valid token initialized
      if (AuthService.token == null ||
          AuthService.token!.trim().isEmpty ||
          AuthService.token == 'null') {
        await AuthService.init();
      }

      final validToken = AuthService.token;
      if (validToken == null ||
          validToken.trim().isEmpty ||
          validToken == 'null') {
        AppLoggerHelper.error(
          "getProfileData aborted: Token is severely missing or corrupt.",
        );
        return;
      }

      final response = await NetworkCaller().getRequest(
        AppUrls.getProfile,
        token: 'Bearer ${validToken.trim()}',
      );

      if (response.isSuccess && response.responseData != null) {
        profileDataModel.value = ProfileModel.fromJson(response.responseData);
        nameController.text = profileDataModel.value.data?.name ?? "";
        imageUrl.value = profileDataModel.value.data?.profileImage ?? "";
      } else {
        log('Failed to fetch profile: ${response.statusCode}');
        AppLoggerHelper.error(
          'Failed to fetch profile: ${response.statusCode}',
        );
      }
    } catch (e) {
      log('Error fetching profile data: $e');
      AppLoggerHelper.error(e.toString());
    } finally {
      if (showLoader) {
        isLoading.value = false;
      }
    }
  }

  /// Check if profile information is complete (age, gender, height, weight, activityLevel, goal)
  void checkProfileCompletion() {
    final data = profileDataModel.value?.data;
    if (data == null) return;

    bool isIncomplete =
        data.age == null ||
        data.gender == null ||
        data.gender!.trim().isEmpty ||
        data.height == null ||
        data.weight == null ||
        data.activityLevel == null ||
        data.activityLevel!.trim().isEmpty ||
        data.goal == null ||
        data.goal!.trim().isEmpty;

    if (isIncomplete) {
      Get.to(() => const EditPersonalInfoScreen());
    }
  }

  /// Updated Profile Data Method
  final isProfileUpdateLoading = false.obs;
  Future<void> updateAccount() async {
    try {
      isProfileUpdateLoading(true);

      final Map<String, dynamic> dataMap = {};

      if (nameController.text.trim().isNotEmpty) {
        dataMap['name'] = nameController.text.trim();
      }
      dio.FormData formData = dio.FormData.fromMap({
        "bodyData": jsonEncode(dataMap),
        if (profileImage.value != null)
          "profileImage": await dio.MultipartFile.fromFile(
            profileImage.value!.path,
            filename: profileImage.value!.path.split('/').last,
          ),
      });
      final response = await NetworkCaller().putRequest(
        AppUrls.updateProfile,
        body: formData,
        token: 'Bearer ${AuthService.token}',
      );
      if (response.isSuccess) {
        //AppSnackBar.success('Profile updated successfully');

        await getProfileData();
      } else {
        AppSnackBar.error(response.errorMessage);
      }
    } catch (e) {
      AppLoggerHelper.error(e.toString());
      AppSnackBar.error("Something went wrong. Try again later.");
    } finally {
      isProfileUpdateLoading(false);
    }
  }

  /// delete account
  Future<void> deleteAccount() async {
    try {
      LoadingWidget();
      final response = await NetworkCaller().deleteRequest(
        AppUrls.deleteUserProfile,
        token: 'Bearer ${AuthService.token}',
      );
      if (response.isSuccess) {
        HideLoadingWidget();
        AppToasts.successToast(message: 'Your account deleted successfully.');
        //Get.offAll(()=>LoginScreen());
      } else {
        HideLoadingWidget();
        AppToasts.errorToast(
          message: response.responseData['message'],
          toastGravity: ToastGravity.TOP,
        );
        AppLoggerHelper.error(
          'Failed to delete account: ${response.statusCode}',
        );
      }
    } catch (e) {
      HideLoadingWidget();
      AppToasts.errorToast(
        message: e.toString(),
        toastGravity: ToastGravity.TOP,
      );
      AppLoggerHelper.error(e.toString());
    } finally {
      HideLoadingWidget();
    }
  }

  ///
  @override
  void onClose() {
    // nameController.dispose();
    // phoneNumberController.dispose();
    // addressController.dispose();
    super.onClose();
  }
}
