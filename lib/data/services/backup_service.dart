import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../db/database_helper.dart';
import '../models/password_model.dart';

class BackupService {
  Future<String?> exportPasswords() async {
    try {
      final passwords = await DatabaseHelper.instance.readAllPasswords();
      final jsonList = passwords.map((p) => p.toJson()).toList();
      final jsonString = jsonEncode(jsonList);

      // Convert String to Uint8List
      final bytes = utf8.encode(jsonString);

      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Backup',
        fileName: 'passwords_backup.json',
        type: FileType.custom,
        allowedExtensions: ['json'],
        bytes: bytes, // <--- ADD THIS LINE
      );

      return outputFile; // The file is already written by the picker
    } catch (e) {
      print('Export error: $e');
      rethrow;
    }
  }

  Future<bool> importPasswords() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final jsonString = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(jsonString);

        for (var json in jsonList) {
          // Check if password exists or just insert?
          // We'll just insert new ones or ignore if ID conflict?
          // Better to ignore ID and insert as new to avoid conflicts if DBs merged?
          // User said "data can be backed up... data can be backed up using this file".
          // I will treat it as a restore. I'll insert cleanly.
          final password = Password.fromJson(json);
          // Reset ID to let AutoIncrement handle it to avoid conflicts
          password.id = null;
          await DatabaseHelper.instance.create(password);
        }
        return true;
      }
      return false;
    } catch (e) {
      print('Import error: $e');
      return false;
    }
  }

  // Request permissions if needed (Storage) - tricky on new Android
  Future<bool> requestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }
}
