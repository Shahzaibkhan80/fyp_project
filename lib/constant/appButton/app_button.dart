import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String btnText;
  final VoidCallback ontap;
  final List<Color>? gradientColors;

  const AppButton({
    super.key,
    required this.btnText,
    required this.ontap,
    this.gradientColors,
    required Color color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: ontap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors ?? [Colors.blue, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            btnText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
