import 'package:flutter/material.dart';
import 'dart:io'; // Needed for File operations
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p; // Use 'as p' to avoid conflicts

// --- Make sure these imports point to your actual files ---
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';

// --- Renamed to ProfileSettingsScreen as discussed ---
class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  bool _appNotifications = true;
  File? _profileImageFile; // <-- State variable for the image file

  @override
  void initState() {
    super.initState();
    _loadProfileImage(); // Try to load existing image when screen starts
  }

  // --- NEW: Load saved image path (Example) ---
  Future<void> _loadProfileImage() async {
    // TODO: Replace this with your actual local DB call
    // String? savedPath = await yourLocalDatabase.getProfilePath();
    String? savedPath; // Placeholder

    if (savedPath != null && await File(savedPath).exists()) {
      setState(() {
        _profileImageFile = File(savedPath);
      });
    }
  }

  // --- NEW: Function to pick and save image ---
  Future<void> _pickAndSaveImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        final Directory appDir = await getApplicationDocumentsDirectory();
        final String fileName =
            'profile_${DateTime.now().millisecondsSinceEpoch}${p.extension(pickedFile.path)}';
        final String newPath = p.join(appDir.path, fileName);
        final File newImage = await File(pickedFile.path).copy(newPath);

        setState(() {
          _profileImageFile = newImage;
        });

        // TODO: Save the 'newPath' to your local database here
        // await yourLocalDatabase.saveUserProfilePath(newPath);
        print("Image saved locally at: $newPath");
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print("Error picking/saving image: $e");
      // Handle potential errors (e.g., permissions denied)
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Could not pick image: $e")));
    }
  }

  // --- NEW: Function to show Gallery/Camera options ---
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Change Picture"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Choose from Gallery"),
              onTap: () {
                Navigator.of(context).pop(); // Close this dialog
                _pickAndSaveImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take with Camera"),
              onTap: () {
                Navigator.of(context).pop(); // Close this dialog
                _pickAndSaveImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- UPDATED: _showEditProfileDialog ---
  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
                const SizedBox(height: 10),
                // --- UPDATED Profile Picture Area ---
                GestureDetector(
                  // <-- Wrapped with GestureDetector
                  onTap: _showImageSourceDialog, // <-- Call the option dialog
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.primaryGreen,
                        // --- Show picked image OR placeholder ---
                        backgroundImage: _profileImageFile != null
                            ? FileImage(_profileImageFile!) as ImageProvider
                            : null, // Use null if no image, CircleAvatar handles background
                        child: _profileImageFile == null
                            ? const Icon(Icons.person,
                                size: 50, color: Colors.white)
                            : null,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.black
                              .withOpacity(0.4), // Slightly darker for contrast
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, color: Colors.white, size: 30),
                          Text("Change Picture",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                ),
                // --- End Updated Area ---
                const SizedBox(height: 25),
                _buildEditableField("Edit Name", "Buto Green"),
                const SizedBox(height: 15),
                _buildEditableField("Edit Email", "butogreen@pg.co"),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement Save Profile Logic
                    print("Save Changes Tapped!");
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    minimumSize: const Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: const Text("Save Changes",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- Other Dialogs (_showChangePasswordDialog, _showLogoutDialog) remain the same ---
  void _showChangePasswordDialog(BuildContext context) {/* ... as before ... */}
  void _showLogoutDialog(BuildContext context) {/* ... as before ... */}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          AppStrings.profileSettings,
          style: TextStyle(color: AppColors.darkText, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        children: <Widget>[
          // --- UPDATED _buildProfileHeader to show image ---
          _buildProfileHeader(),
          // --- End Update ---
          const SizedBox(height: 30),
          _buildSectionTitle(AppStrings.account),
          _buildSettingsOption(AppStrings.editProfile,
              onTap: () => _showEditProfileDialog(context)),
          _buildSettingsOption(AppStrings.editPassword,
              onTap: () => _showChangePasswordDialog(context)),
          _buildSectionTitle(AppStrings.notifications),
          _buildNotificationOption(AppStrings.appNotifications),
          _buildSectionTitle(AppStrings.others),
          _buildSettingsOption(AppStrings.help, onTap: () {}),
          const SizedBox(height: 40),
          _buildLogoutOption(onTap: () => _showLogoutDialog(context)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  // --- UPDATED _buildProfileHeader ---
  Widget _buildProfileHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.primaryGreen,
          backgroundImage:
              _profileImageFile != null ? FileImage(_profileImageFile!) : null,
          child: _profileImageFile == null
              ? const Icon(Icons.person, size: 30, color: Colors.white)
              : null,
        ),
        const SizedBox(width: 15),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Buto Green",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkText)),
            Text("butogreen@pg.co",
                style: TextStyle(fontSize: 14, color: AppColors.greyText)),
          ],
        ),
      ],
    );
  }

  // --- End Update ---
  Widget _buildEditableField(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style:
                    const TextStyle(color: AppColors.greyText, fontSize: 12)),
            Text(value,
                style:
                    const TextStyle(color: AppColors.darkText, fontSize: 16)),
          ],
        ),
        const Icon(Icons.edit, size: 20, color: AppColors.greyText),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.darkText),
      ),
    );
  }

  Widget _buildSettingsOption(String title, {VoidCallback? onTap}) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: const TextStyle(fontSize: 15)),
          trailing: onTap != null
              ? const Icon(Icons.arrow_forward_ios,
                  size: 16, color: AppColors.greyText)
              : null,
          contentPadding: EdgeInsets.zero,
          onTap: onTap,
        ),
        const Divider(height: 1, color: AppColors.divider),
      ],
    );
  }

  Widget _buildNotificationOption(String title) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: const TextStyle(fontSize: 15)),
          trailing: Switch(
            value: _appNotifications,
            onChanged: (bool value) {
              setState(() {
                _appNotifications = value;
              });
            },
            activeColor: AppColors.primaryGreen,
          ),
          contentPadding: EdgeInsets.zero,
        ),
        const Divider(height: 1, color: AppColors.divider),
      ],
    );
  }

  Widget _buildLogoutOption({VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          AppStrings.logout,
          style: TextStyle(fontSize: 15, color: AppColors.redWarning),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String hint) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        isDense: true,
      ),
    );
  }
}
