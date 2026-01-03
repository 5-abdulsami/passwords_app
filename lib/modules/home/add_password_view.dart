import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_password_controller.dart';

class AddPasswordView extends StatelessWidget {
  AddPasswordView({super.key});
  final AddPasswordController controller = Get.put(AddPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.titleController,
              decoration: const InputDecoration(labelText: 'Site / App Name', prefixIcon: Icon(Icons.title)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.usernameController,
              decoration: const InputDecoration(labelText: 'Username / Email', prefixIcon: Icon(Icons.person)),
            ),
            const SizedBox(height: 16),
            Obx(() => TextField(
              controller: controller.passwordController,
              obscureText: !controller.isPasswordVisible.value,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.vpn_key),
                suffixIcon: IconButton(
                  icon: Icon(controller.isPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: controller.togglePasswordVisibility,
                ),
              ),
            )),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.savePassword,
                child: const Text('Save Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
