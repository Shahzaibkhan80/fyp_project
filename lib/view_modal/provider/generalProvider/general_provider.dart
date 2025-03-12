import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyp_project/navigationScreen/appNavigation.dart';

class GeneralProvider extends ChangeNotifier {
  // Splash Scren Working

  // void setLoading(BuildContext context) {
  //   Timer(Duration(seconds: 5), () {
  //     Appnavigation.pushscreen(context, RouteName.loginscreen);
  //     notifyListeners();
  //   });
  // }
  void setLoading(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      AppNavigators.changescreen(context, '/LoginScreen');
    });
  }

  //Login Screen
  TextEditingController loginemailController = TextEditingController();
  TextEditingController loginpassController = TextEditingController();

  //Register Screen
  TextEditingController regnameController = TextEditingController();
  TextEditingController regContactNoController = TextEditingController();
  TextEditingController regAgeController = TextEditingController();

  //Select Gender
  // String? selectgender;

  // void setGender(String gender) {
  //   selectgender = gender;
  //   notifyListeners();
  // }

  TextEditingController genderController = TextEditingController();
}
