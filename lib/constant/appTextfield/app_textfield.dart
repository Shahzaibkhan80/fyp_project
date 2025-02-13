import 'package:flutter/material.dart';

class AppTextfield extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Icon prefixIcon;
  final Widget? suffixIcon;
  final Color borderColor;
  final double borderRadius;

  const AppTextfield(
      {super.key,
      required this.labelText,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      required this.prefixIcon,
      this.suffixIcon,
      this.borderColor = Colors.grey,
      this.borderRadius = 8});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.blue, fontSize: 14),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
            border: InputBorder.none,
            prefixIcon: SizedBox(
              width: 1,
              child: Row(
                children: [
                  prefixIcon,
                  SizedBox(
                    width: 5,
                  ),
                  Container(height: 20, width: 1, color: Colors.grey),
                ],
              ),
            ),
            suffixIcon: suffixIcon,

            // contentPadding: const EdgeInsets.symmetric(vertical: 15),
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(borderRadius),
            //   borderSide: BorderSide(color: borderColor),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(borderRadius),
            //   borderSide: BorderSide(color: borderColor, width: 1),
            // ),
            // errorBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(borderRadius),
            //   borderSide: const BorderSide(color: Colors.red, width: 1),
            // ),
          ),
        ),
      ),
    );
  }
}
