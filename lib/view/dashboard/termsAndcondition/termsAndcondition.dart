import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Text(
            'Your terms and conditions go here.\n\n'
            '1. Use this app responsibly.\n'
            '2. Do not share your password.\n'
            '3. ...',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
