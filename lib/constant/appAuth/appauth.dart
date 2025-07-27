import 'package:flutter/material.dart';
import 'package:fyp_project/navigationScreen/appNavigation.dart';
import 'package:fyp_project/routings/routeName/routes_name.dart';
import 'package:fyp_project/utilis/customFlushbar/customFlashbar.dart';
import 'package:fyp_project/view_modal/provider/generalProvider/general_provider.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart'; // Make sure this is imported

import '../../view/auth/authServices/authservices.dart';
import '../../view_modal/provider/textController/text_controller.dart';

class AppAuth {
  final BuildContext context;

  AppAuth(this.context);

  Future<bool> register() async {
    final reg = Provider.of<GeneralProvider>(context, listen: false);
    final name = TextController.regnameController.text.trim();
    final email = TextController.regemailController.text.trim();
    final pass = TextController.regpassController.text.trim();
    final contactNo = TextController.regContactNoController.text.trim();
    final age = TextController.regAgeController.text.trim();
    final gender = reg.selectgender;

    if (name.isEmpty ||
        email.isEmpty ||
        pass.isEmpty ||
        contactNo.isEmpty ||
        age.isEmpty ||
        gender == null) {
      CustomFlushBar.showInfo(context, "Please fill all the fields");
      return false;
    }

    final authregService = Authservices();

    final error = await authregService.registerUser(
      name: name,
      email: email,
      password: pass,
      contactNo: contactNo,
      age: age,
      gender: gender,
    );

    if (error == null) {
      // Clear form data
      TextController.regnameController.clear();
      TextController.regemailController.clear();
      TextController.regpassController.clear();
      TextController.regContactNoController.clear();
      TextController.regAgeController.clear();
      reg.selectgender = null;

      // Show success message before returning
      CustomFlushBar.showSuccess(context, "Registration successful!");

      // Wait for FlushBar to be visible
      await Future.delayed(Duration(seconds: 3));

      // Navigate to next screen
      if (context.mounted) {
        AppNavigators.nextscreen(context, RouteName.uploadimage);
      }

      return true;
    } else {
      CustomFlushBar.showError(context, error);
      return false;
    }
  }

  Future<bool> login() async {
    // Similar implementation for login...
    final email = TextController.loginemailController.text.trim();
    final password = TextController.loginpassController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Direct implementation
      if (context.mounted) {
        Flushbar(
          message: "Please fill all the fields",
          icon: Icon(Icons.info_outline, color: Colors.white),
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context);
      }
      return false;
    }

    final authloginService = Authservices();
    final error =
        await authloginService.loginUser(email: email, password: password);

    if (error == null) {
      CustomFlushBar.showSuccess(context, "Login successful");
      TextController.loginemailController.clear();
      TextController.loginpassController.clear();

      // Wait for FlushBar to be visible
      await Future.delayed(Duration(seconds: 4));

      // Navigate to next screen
      if (context.mounted) {
        AppNavigators.nextscreen(context, RouteName.uploadimage);
      }
      return true;
    } else {
      CustomFlushBar.showError(context, error);
      return false;
    }
  }
}
