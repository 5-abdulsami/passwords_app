import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  var isFingerprintEnabled = false.obs;
  var hasPasswordSet = false.obs;
  var isAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    isFingerprintEnabled.value = prefs.getBool('use_fingerprint') ?? false;
    hasPasswordSet.value = prefs.getString('app_password') != null;
  }

  Future<bool> authenticateWithBiometrics() async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();

      if (!canAuthenticate) return false;

      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );

      if (didAuthenticate) isAuthenticated.value = true;
      return didAuthenticate;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> loginWithPassword(String inputPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final storedPassword = prefs.getString('app_password');
    if (storedPassword == inputPassword) {
      isAuthenticated.value = true;
      return true;
    }
    return false;
  }

  Future<void> setAppPassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_password', password);
    hasPasswordSet.value = true;
    isAuthenticated.value = true; // Auto login after set
  }

  Future<void> toggleFingerprint(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('use_fingerprint', value);
    isFingerprintEnabled.value = value;
  }

  void logout() {
    isAuthenticated.value = false;
  }
}
