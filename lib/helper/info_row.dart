import 'package:flutter/material.dart';

Widget infoRow(BuildContext context, String label, String value) {
  final Color textColor =
      Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            "$label:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
              color: textColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 17,
              color: textColor,
            ),
          ),
        ),
      ],
    ),
  );
}
