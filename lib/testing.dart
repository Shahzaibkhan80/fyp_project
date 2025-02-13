import 'package:flutter/material.dart';
import 'package:fyp_project/constant/appButton/app_button.dart';
import 'package:fyp_project/constant/appIcons/app_Icon.dart';
import 'package:fyp_project/constant/appTextfield/app_textfield.dart';

class Testing extends StatelessWidget {
  const Testing({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController check = TextEditingController();
    // TextEditingController check1 = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: AppButton(
                btnText: 'Button 1',
                ontap: () {},
                color: Colors.blue,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            AppTextfield(
              labelText: "Email",
              controller: check,
              prefixIcon: AppIcons.customIcon(Icons.email),
            ),
          ],
        ),
      ),
    );
  }
}
