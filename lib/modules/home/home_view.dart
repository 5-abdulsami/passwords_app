import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import '../auth/settings_view.dart';
import 'add_password_view.dart';
import '../../data/models/password_model.dart';
import 'package:flutter/services.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Passwords'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.to(() => SettingsView()),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.passwords.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_open, size: 64, color: Colors.grey[700]),
                const SizedBox(height: 16),
                Text(
                  'No passwords yet',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.passwords.length,
          itemBuilder: (context, index) {
            final password = controller.passwords[index];
            return PasswordCard(
              password: password,
              onDelete: () => controller.deletePassword(password.id!),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddPasswordView()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PasswordCard extends StatefulWidget {
  final Password password;
  final VoidCallback onDelete;

  const PasswordCard({
    super.key,
    required this.password,
    required this.onDelete,
  });

  @override
  State<PasswordCard> createState() => _PasswordCardState();
}

class _PasswordCardState extends State<PasswordCard> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.password.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () {
                    Get.defaultDialog(
                      contentPadding: const EdgeInsets.all(16),
                      title: "Delete Password",
                      middleText:
                          "Are you sure you want to delete this password?",
                      textConfirm: "Delete",
                      textCancel: "Cancel",
                      cancelTextColor: Colors.white,
                      confirmTextColor: Colors.white,
                      buttonColor: Colors.redAccent,
                      onConfirm: () {
                        widget.onDelete();
                        Get.back(); // Closes the dialog
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                SelectableText(widget.password.username),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.vpn_key, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: isVisible
                      ? SelectableText(widget.password.password)
                      : const Text('••••••••••••'),
                ),
                IconButton(
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(text: widget.password.password),
                    );
                    Get.snackbar(
                      'Copied',
                      'Password copied to clipboard',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
