import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/app_snackber.dart';
import 'package:project_structure/core/services/auth_service.dart';
import 'package:project_structure/core/services/network_caller.dart';
import 'package:project_structure/core/utils/constants/app_urls.dart';
import 'package:project_structure/core/utils/logging/logger.dart';
import 'package:project_structure/features/nav_bar/presentation/screens/nav_bar.dart';
import 'package:project_structure/features/profile/controller/profile_controller.dart';

class ProfileInformationController extends GetxController {
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  final selectedGender = "".obs;
  final selectedActivityLevel = "".obs;
  final selectedGoal = "".obs;
  final isLoading = false.obs;

  final List<String> genderItems = ["Male", "Female"];

  final List<String> activityLevels = [
    "Low / Sedentary",
    "Light",
    "Moderate",
    "High",
  ];

  final List<String> goalItems = ["Weight Loss", "Maintain", "Weight Gain"];

  @override
  void onInit() {
    super.onInit();
    _loadExistingProfileData();
  }

  void _loadExistingProfileData() {
    if (Get.isRegistered<ProfileController>()) {
      final profileController = Get.find<ProfileController>();
      final data = profileController.profileDataModel.value?.data;
      if (data != null) {
        ageController.text = data.age?.toString() ?? "";
        heightController.text = data.height?.toString() ?? "";
        weightController.text = data.weight?.toString() ?? "";
        selectedGender.value = data.gender ?? "";
        selectedActivityLevel.value = _reverseMapActivityLevel(
          data.activityLevel,
        );
        selectedGoal.value = _reverseMapGoal(data.goal);
      }
    }
  }

  String _reverseMapActivityLevel(String? level) {
    if (level == null) return "";
    switch (level.toUpperCase()) {
      case "SEDENTARY":
        return "Low / Sedentary";
      case "LIGHT":
        return "Light";
      case "MODERATE":
        return "Moderate";
      case "HIGH":
        return "High";
      default:
        return level;
    }
  }

  String _reverseMapGoal(String? goal) {
    if (goal == null) return "";
    switch (goal) {
      case "Loss":
        return "Weight Loss";
      case "Gain":
        return "Weight Gain";
      case "Maintain":
        return "Maintain";
      default:
        return goal;
    }
  }

  Future<void> submitProfile({bool getBack = false}) async {
    if (ageController.text.isEmpty ||
        heightController.text.isEmpty ||
        weightController.text.isEmpty ||
        selectedGender.isEmpty ||
        selectedActivityLevel.isEmpty ||
        selectedGoal.isEmpty) {
      AppSnackBar.error("Please fill in all fields");
      return;
    }

    isLoading.value = true;
    try {
      final Map<String, dynamic> body = {
        "age": int.tryParse(ageController.text) ?? 0,
        "gender": selectedGender.value,
        "height": double.tryParse(heightController.text) ?? 0.0,
        "weight": double.tryParse(weightController.text) ?? 0.0,
        "activityLevel": _mapActivityLevel(selectedActivityLevel.value),
        "goal": _mapGoal(selectedGoal.value),
      };

      final response = await NetworkCaller().putRequest(
        AppUrls.updateProfile,
        body: body,
        token: 'Bearer ${AuthService.token}',
      );

      AppLoggerHelper.debug(
        "Body data : ${body} \n Token : ${AuthService.token}",
      );
      if (response.isSuccess) {
        if (getBack == false) {
          Get.offAll(() => NavBar());
        } else if (getBack == true) {
          Get.back();
        }
        AppSnackBar.success("Profile information updated successfully!");
        clearField();
      } else {
        AppSnackBar.error(response.errorMessage);
      }
    } catch (e) {
      AppSnackBar.error("Something went wrong. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  String _mapActivityLevel(String level) {
    switch (level) {
      case "Low / Sedentary":
        return "SEDENTARY";
      case "Light":
        return "LIGHT";
      case "Moderate":
        return "MODERATE";
      case "High":
        return "HIGH";
      default:
        return level.toUpperCase();
    }
  }

  String _mapGoal(String goal) {
    switch (goal) {
      case "Weight Loss":
        return "Loss";
      case "Weight Gain":
        return "Gain";
      case "Maintain":
        return "Maintain";
      default:
        return goal;
    }
  }

  @override
  void onClose() {
    // ageController.dispose();
    // heightController.dispose();
    // weightController.dispose();
    super.onClose();
  }

  void clearField() {
    Get.back();
    ageController.clear();
    heightController.clear();
    weightController.clear();
    selectedActivityLevel.value = "";
    selectedGoal.value = "";
    selectedGender.value = "";
  }
}
