import 'package:flutter/material.dart';
import '../../view/auth/loginScreen/login_screen.dart';
import '../../view/auth/registerScreen/register_screen.dart';
import '../../view/splashScreen/splash_screen.dart';
import '../routeName/routes_name.dart';

class RouteScreen {
  static Map<String, WidgetBuilder> getScreens() {
    return {
      RouteName.splashscreen: (context) => SplashScreen(),
      RouteName.loginscreen: (context) => LoginScreen(),
      RouteName.regscreen: (context) => RegisterScreen(),
    };
  }
}
