```md
# 🔐 Passwords — Password Manager App

A secure, offline-first password manager built with **Flutter**, designed to keep your credentials safe using **biometric authentication** and **local-only storage**. No cloud, no tracking, no internet dependency.

---

## ✨ Features

- 🔐 **Biometric Authentication**  
  Secure app access using fingerprint or face recognition.

- 📱 **Offline First**  
  All passwords are stored locally using SQLite. No network access required.

- 🌙 **Dark Theme (Material 3)**  
  Clean, modern UI following Material Design 3 guidelines.

- 💾 **Backup & Restore**  
  Export and import passwords securely as JSON files.

- 📋 **Copy to Clipboard**  
  Quickly copy usernames or passwords with one tap.

- 👁️ **Show / Hide Passwords**  
  Toggle password visibility when needed.

- 🗑️ **Delete Confirmation**  
  Prevent accidental deletions with confirmation dialogs.

- ✨ **Polished UI**  
  Elegant typography using **Google Fonts (Outfit)**.

---

## 📸 Screenshots

> *(Add screenshots of the app UI here)*

---

## 🧱 Tech Stack

- **Framework**: Flutter `>= 3.10.4`
- **State Management**: GetX `^4.7.3`
- **Database**: SQLite (sqflite `^2.4.2`)
- **Authentication**: local_auth `^3.0.0`
- **Storage**: shared_preferences `^2.5.4`
- **File Operations**: file_picker `^10.3.8`
- **Permissions**: permission_handler `^12.0.1`
- **UI/UX**:
  - Material Design 3
  - Google Fonts (Outfit)
  - Custom dark theme

---

## 📁 Project Structure

```
lib/
├── main.dart                     # App entry point
├── core/
│   └── theme/
│       └── app_theme.dart        # App theme configuration
├── data/
│   ├── db/
│   │   └── database_helper.dart  # SQLite database operations
│   ├── models/
│   │   └── password_model.dart   # Password data model
│   └── services/
│       └── backup_service.dart   # Import/export functionality
└── modules/
    ├── auth/
    │   ├── auth_controller.dart      # Biometric authentication logic
    │   ├── login_view.dart           # Login screen
    │   ├── settings_controller.dart  # Settings logic
    │   └── settings_view.dart        # Settings screen
    └── home/
        ├── home_controller.dart      # Home screen logic
        ├── home_view.dart            # Password list screen
        ├── add_password_controller.dart
        └── add_password_view.dart    # Add password screen
```

---

## 🚀 Getting Started

### ✅ Prerequisites

- Flutter SDK `>= 3.10.4`
- Dart SDK `>= 3.10.4`
- Android Studio or VS Code
- Android SDK (for Android builds)
- Xcode (for iOS builds — macOS only)

---

### 📥 Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/passwords.git
   cd passwords
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

---

### 🏗️ Build Commands

- **Build APK (Android)**
  ```bash
  flutter build apk --release
  ```

- **Build App Bundle (Android)**
  ```bash
  flutter build appbundle --release
  ```

- **Build iOS**
  ```bash
  flutter build ios --release
  ```

---

## ⚙️ Configuration

### 🤖 Android Permissions

Biometric permission is already configured in `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.USE_BIOMETRIC" />
```

---

### 🍎 iOS Configuration

Biometric permissions are handled automatically by the `local_auth` package. No additional setup required beyond standard iOS project configuration.

---

## 📘 Usage Guide

### 🔓 First Launch

1. Open the app.
2. Authenticate using fingerprint or face recognition.
3. Start adding your passwords.

---

### ➕ Adding a Password

1. Tap the **+** button on the home screen.
2. Enter the title, username, and password.
3. Tap **Save**.

---

### 👀 Viewing Passwords

- Passwords are hidden by default (`••••••••••`).
- Tap the **eye icon** to show or hide the password.
- Tap the **copy icon** to copy the password to the clipboard.

---

### 🗑️ Deleting Passwords

1. Tap the **delete icon** on a password card.
2. Confirm deletion in the dialog.

---

### 💾 Backup & Restore

1. Open **Settings** (gear icon).
2. **Export**: Tap *Export Passwords* to save data as a JSON file.
3. **Import**: Tap *Import Passwords* to restore from a JSON backup.

---

## 🧩 Key Components

### `AuthController`

Handles biometric authentication using the `local_auth` package.

### `DatabaseHelper`

Singleton class managing all SQLite database operations (CRUD).

### `BackupService`

Manages import/export of passwords using JSON files.

### `AppTheme`

Custom Material Design 3 dark theme with Google Fonts integration.

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  get: ^4.7.3                    # State management
  sqflite: ^2.4.2                # SQLite database
  path: ^1.9.1                   # Path utilities
  path_provider: ^2.1.5          # File system paths
  local_auth: ^3.0.0             # Biometric authentication
  shared_preferences: ^2.5.4     # Local key-value storage
  google_fonts: ^6.3.3           # Custom fonts
  intl: ^0.20.2                  # Internationalization
  file_picker: ^10.3.8           # File picker
  permission_handler: ^12.0.1    # Runtime permissions
  flutter_lints: ^6.0.0          # Linting rules
```

---

## 🔐 Security Notes

✅ Biometric authentication required on launch  
✅ Local-only storage (no cloud, no internet)  
✅ Passwords hidden by default  
✅ Secure clipboard handling  

⚠️ **Important**  
Passwords are currently stored **in plaintext** in the local SQLite database. For production use, it is strongly recommended to implement **database encryption**.

---

## 🛣️ Future Enhancements

- [ ] Database encryption
- [ ] Password strength indicator
- [ ] Password generator
- [ ] Search functionality
- [ ] Categories / folders
- [ ] Password expiry reminders
- [ ] Auto-lock timer
- [ ] Optional cloud backup
- [ ] Master password fallback

---

## 🤝 Contributing

Contributions are welcome!

1. Fork the repository
2. Create a feature branch
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. Commit your changes
   ```bash
   git commit -m "Add AmazingFeature"
   ```
4. Push to the branch
   ```bash
   git push origin feature/AmazingFeature
   ```
5. Open a Pull Request

---

## 📄 License

This project is licensed under the **MIT License**. See the `LICENSE` file for details.

---

## 🙏 Acknowledgments

- GetX for state management
- Google Fonts for typography
- Material Design 3 for UI guidelines
- Flutter community for excellent packages

---

## 👤 Author

**Abdul Sami**

- GitHub: [@5-abdulsami](https://github.com/5-abdulsami)
- Email: [5abdulsami2004@gmail.com](mailto:5abdulsami2004@gmail.com)

---

## ⭐ Support

If you find this project helpful, please consider giving it a ⭐️ on GitHub!
```