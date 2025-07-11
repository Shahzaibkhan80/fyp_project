import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fyp_project/navigationScreen/appNavigation.dart';

class GeneralProvider extends ChangeNotifier {
  // Splash Screen Working
  void setLoading(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      AppNavigators.changescreen(context, '/RegisterScreen');
    });
  }

  // Select Gender
  String? selectgender;
  void setGender(String gender) {
    selectgender = gender;
    notifyListeners();
  }

  // Textfield visibility
  bool isvisible = true;
  void iconToggle() {
    isvisible = !isvisible;
    notifyListeners();
  }

  // Image upload functionality
  File? selectedImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      // Save image path to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selected_image_path', pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> uploadImage(BuildContext context) async {
    if (selectedImage == null) return;
    // Yahan apni upload logic lagayen (API call, Firebase, etc.)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image uploaded!')),
    );
    // notifyListeners(); // Agar UI update karna ho
  }
}
