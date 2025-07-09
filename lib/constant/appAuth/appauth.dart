import 'package:flutter/material.dart';
import 'package:fyp_project/navigationScreen/appNavigation.dart';
import 'package:fyp_project/routings/routeName/routes_name.dart';
import 'package:fyp_project/view_modal/provider/generalProvider/general_provider.dart';
import 'package:provider/provider.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all the fields")),
      );
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration successful")),
      );
      TextController.regnameController.clear();
      TextController.regemailController.clear();
      TextController.regpassController.clear();
      TextController.regContactNoController.clear();
      TextController.regAgeController.clear();
      reg.selectgender = null;
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      return false;
    }
  }

  void login() {
    final email = TextController.loginemailController.text.trim();
    final password = TextController.loginpassController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all the fields")),
      );
      return;
    }
    final authloginService = Authservices();
    authloginService.loginUser(email: email, password: password).then(
      (value) {
        if (value == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login successful")),
          );
          TextController.loginemailController.clear();
          TextController.loginpassController.clear();
          AppNavigators.nextscreen(context, RouteName.uploadimage);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(value)),
          );
        }
      },
    );
  }
}
