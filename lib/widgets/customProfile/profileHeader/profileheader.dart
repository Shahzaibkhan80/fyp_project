import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String? email;

  const ProfileHeader({
    super.key,
    required this.name,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: theme.textTheme.titleLarge?.color,
          ),
        ),
        if (email != null && email!.isNotEmpty)
          Text(
            email!,
            style: TextStyle(
              fontSize: 14,
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
      ],
    );
  }
}
