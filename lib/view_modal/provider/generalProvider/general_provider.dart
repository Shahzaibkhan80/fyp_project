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

  //Register Screen

  //Select Gender
  // String? selectgender;

  // void setGender(String gender) {
  //   selectgender = gender;
  //   notifyListeners();
  // }

  //textfield visibility
  bool isvisible = true;
  void iconToggle() {
    isvisible = !isvisible;
    notifyListeners();
  }
}
