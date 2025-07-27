import 'package:flutter/material.dart';

class AppTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final Color borderColor;
  final double borderRadius;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final String? errorText;

  const AppTextfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.borderColor = Colors.grey,
    this.borderRadius = 8.0,
    this.validator,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          style: const TextStyle(color: Colors.blue, fontSize: 14),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            // Hide default error text if we're using custom error display
            errorStyle: errorText != null ? const TextStyle(height: 0) : null,
          ),
        ),
        // Show custom error message if provided
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
