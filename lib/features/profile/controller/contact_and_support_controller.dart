import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ContactAndSupportController extends GetxController {
  final nameTEController = TextEditingController();
  final emailTEController = TextEditingController();
  final descriptionTEController = TextEditingController();

  final Rx<File?> selectedImage = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      selectedImage.value = File(file.path);
    }
  }

  final RxString selectedCategory = "".obs;

  void changeCategory(String value) {
    selectedCategory.value = value;
  }
}
