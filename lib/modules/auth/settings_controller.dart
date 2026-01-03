import 'package:get/get.dart';
import '../../data/services/backup_service.dart';
import 'auth_controller.dart';

class SettingsController extends GetxController {
  final AuthController authController = Get.find();
  final BackupService _backupService = BackupService();

  Future<void> backupData() async {
    final path = await _backupService.exportPasswords();
    if (path != null) {
      Get.snackbar('Success', 'Backup saved to $path');
    }
  }

  Future<void> restoreData() async {
    final success = await _backupService.importPasswords();
    if (success) {
      Get.snackbar('Success', 'Passwords restored successfully');
    } else {
      Get.snackbar('Error', 'Failed to restore data');
    }
  }
  
  void toggleFingerprint(bool val) {
    authController.toggleFingerprint(val);
  }
}
