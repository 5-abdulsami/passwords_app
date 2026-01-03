import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController authController = Get.find();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 500));
      if (authController.isFingerprintEnabled.value) {
        bool success = await authController.authenticateWithBiometrics();
        if (success) {
          Get.offAllNamed('/home');
        }
      }
    });
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      bool success = await authController.loginWithPassword(passwordController.text);
      if (success) {
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Error', 'Incorrect password',
            backgroundColor: Theme.of(context).colorScheme.error, colorText: Colors.white);
      }
    }
  }

  void _setupPassword() {
    if (_formKey.currentState!.validate()) {
      authController.setAppPassword(passwordController.text);
      Get.offAllNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Obx(() {
            final hasPass = authController.hasPasswordSet.value;
            // Also check if we are authenticated already?
            if (authController.isAuthenticated.value) return const SizedBox.shrink();

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outline, size: 80, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(height: 32),
                    Text(
                      hasPass ? 'Welcome Back' : 'Set Master Password',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Master Password',
                        prefixIcon: Icon(Icons.key),
                      ),
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: hasPass ? _login : _setupPassword,
                        child: Text(hasPass ? 'Login' : 'Set Password'),
                      ),
                    ),
                    if (hasPass && authController.isFingerprintEnabled.value) ...[
                      const SizedBox(height: 24),
                      IconButton(
                        icon: Icon(Icons.fingerprint, size: 48, color: Theme.of(context).colorScheme.secondary),
                        onPressed: () async {
                          bool success =
                              await authController.authenticateWithBiometrics();
                          if (success) {
                            Get.offAllNamed('/home');
                          }
                        },
                      ),
                      const Text('Tap to use Fingerprint'),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
