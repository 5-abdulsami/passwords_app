import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'settings_controller.dart';
import 'auth_controller.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final SettingsController controller = Get.put(SettingsController());
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Obx(() => SwitchListTile(
            title: const Text('Enable Fingerprint Login'),
            value: authController.isFingerprintEnabled.value,
            onChanged: (val) => controller.toggleFingerprint(val),
            secondary: const Icon(Icons.fingerprint),
          )),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.backup),
            title: const Text('Backup Passwords'),
            subtitle: const Text('Save to JSON file'),
            onTap: controller.backupData,
          ),
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text('Restore Passwords'),
            subtitle: const Text('Import from JSON file'),
            onTap: controller.restoreData,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.blueAccent),
            title: const Text('Sign Out'),
            onTap: () {
              authController.logout();
              Get.offAllNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
