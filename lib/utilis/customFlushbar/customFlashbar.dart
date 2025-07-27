import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import '../../constant/appColors/app_color.dart';

class CustomFlushBar {
  static Future<dynamic> customFlushBar(
      BuildContext context, String message, IconData icon, Color iconColor) {
    return Flushbar(
      messageText: Text(
        message,
        style: TextStyle(fontSize: 14, color: AppColors.appBackground),
      ),
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      backgroundColor: AppColors.blackTextClr,
      icon: Icon(
        icon,
        color: iconColor,
      ),
      titleColor: AppColors.appBackground,
      flushbarStyle: FlushbarStyle.FLOATING,
      borderRadius: BorderRadius.circular(9.8),
      duration: Duration(seconds: 4),
    ).show(context);
  }

  // Helper methods for common notifications
  static Future<dynamic> showSuccess(BuildContext context, String message) {
    return customFlushBar(context, message, Icons.check_circle, Colors.green);
  }

  static Future<dynamic> showError(BuildContext context, String message) {
    return customFlushBar(context, message, Icons.error_outline, Colors.red);
  }

  static Future<dynamic> showInfo(BuildContext context, String message) {
    return customFlushBar(context, message, Icons.info_outline, Colors.red);
  }
}
