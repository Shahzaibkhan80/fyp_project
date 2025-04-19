import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/view/auth/loginScreen/login_screen.dart';
import 'package:fyp_project/view/dashboard/uploadImage/upload_image.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return UploadImage();
        } else {
          return LoginScreen();
        }
      },
    ));
  }
}
