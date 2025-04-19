import 'package:flutter/material.dart';
import 'package:fyp_project/view/auth/forgotScreen/forgot_screen.dart';
import '../../view/auth/loginScreen/login_screen.dart';
import '../../view/auth/registerScreen/register_screen.dart';
import '../../view/dashboard/uploadImage/upload_image.dart';
import '../../view/splashScreen/splash_screen.dart';
import '../routeName/routes_name.dart';

class RouteScreen {
  static Map<String, WidgetBuilder> getScreens() {
    return {
      RouteName.splashscreen: (context) => SplashScreen(),
      RouteName.loginscreen: (context) => LoginScreen(),
      RouteName.regscreen: (context) => RegisterScreen(),
      RouteName.forgotscreen: (context) => ForgotScreen(),
      RouteName.uploadimage: (context) => UploadImage(),
    };
  }
}
