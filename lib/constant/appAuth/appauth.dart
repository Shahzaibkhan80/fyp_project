import 'package:flutter/material.dart';

import 'package:fyp_project/view_modal/provider/generalProvider/general_provider.dart';
import 'package:provider/provider.dart';

import '../../view/auth/authServices/authservices.dart';
import '../../view_modal/provider/textController/text_controller.dart';

class AppAuth {
  final BuildContext context;

  AppAuth(this.context);

  Future<String?> register() async {
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
      return "Please fill all the fields";
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
      return null;
    } else {
      return error;
    }
  }

  Future<String?> login() async {
    final email = TextController.loginemailController.text.trim();
    final password = TextController.loginpassController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      return "Please fill all the fields";
    }

    final authloginService = Authservices();
    final error =
        await authloginService.loginUser(email: email, password: password);

    if (error == null) {
      TextController.loginemailController.clear();
      TextController.loginpassController.clear();
      return null;
    } else {
      return error;
    }
  }
}
