import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color? color;

  final TextStyle? textStyle;
  final VoidCallback? ontap;
  const AppText({
    super.key,
    required this.title,
    this.fontSize = 14,
    this.color,
    this.textStyle,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Text(
        title,
        style: textStyle ??
            TextStyle(
              fontSize: fontSize,
              color: color,
            ),
      ),
    );
  }
}
