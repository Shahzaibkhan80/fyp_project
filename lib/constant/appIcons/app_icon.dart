import 'package:flutter/material.dart';

class AppIcons {
  static const Icon emailIcon = Icon(Icons.email);
  static const Icon nameIcon = Icon(Icons.person_3_sharp);
  static const Icon passwordIcon = Icon(Icons.lock);
  static const Icon suffixIconOff = Icon(Icons.visibility_off_outlined);
  static const Icon suffixIconOnn = Icon(Icons.visibility_outlined);
  static const Icon gender = Icon(Icons.transgender_outlined);
  static const Icon close = Icon(Icons.close);

  static Icon customIcon(IconData iconData,
      {Color color = Colors.grey, double size = 24}) {
    return Icon(
      iconData,
      color: color,
      size: size,
    );
  }
}
