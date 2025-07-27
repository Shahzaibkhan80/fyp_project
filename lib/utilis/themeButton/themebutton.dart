import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_modal/provider/generalProvider/general_provider.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: 24,
      child: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.brightness_6, color: Colors.white),
        onPressed: () {
          Provider.of<GeneralProvider>(context, listen: false).toggleTheme();
        },
      ),
    );
  }
}
