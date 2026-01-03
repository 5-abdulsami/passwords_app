import 'package:get/get.dart';
import '../../data/db/database_helper.dart';
import '../../data/models/password_model.dart';

class HomeController extends GetxController {
  var passwords = <Password>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPasswords();
  }

  Future<void> fetchPasswords() async {
    try {
      isLoading.value = true;
      final result = await DatabaseHelper.instance.readAllPasswords();
      passwords.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addPassword(Password password) async {
    await DatabaseHelper.instance.create(password);
    fetchPasswords();
  }

  Future<void> updatePassword(Password password) async {
    await DatabaseHelper.instance.update(password);
    fetchPasswords();
  }

  Future<void> deletePassword(int id) async {
    await DatabaseHelper.instance.delete(id);
    fetchPasswords();
  }
}
