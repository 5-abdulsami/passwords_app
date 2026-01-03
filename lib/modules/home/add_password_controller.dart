import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/password_model.dart';
import 'home_controller.dart';

class AddPasswordController extends GetxController {
  final HomeController homeController = Get.find();
  
  final titleController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void savePassword() {
    if (titleController.text.isEmpty ||
        usernameController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final newPassword = Password(
      title: titleController.text,
      username: usernameController.text,
      password: passwordController.text,
      createdAt: DateTime.now().toIso8601String(),
    );

    homeController.addPassword(newPassword);
    Get.back();
  }
  
  @override
  void onClose() {
    titleController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
