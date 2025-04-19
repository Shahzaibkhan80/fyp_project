import 'package:flutter/material.dart';
import 'package:fyp_project/constant/appButton/app_button.dart';
import 'package:fyp_project/constant/appIcons/app_Icon.dart';
import 'package:fyp_project/constant/appText/app_text.dart';
import 'package:fyp_project/constant/appTextfield/app_textfield.dart';
import 'package:fyp_project/widgets/customImage/custom_image.dart';

class Testing extends StatelessWidget {
  const Testing({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController check = TextEditingController();

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
              height: 10,
            ),
            AppTextfield(
              hintText: "Email",
              controller: check,
              prefixIcon: AppIcons.customIcon(Icons.mail),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomImage(
                  imageUrl: 'assets/images/doctor.png',
                  title: 'Doctor',
                ),
                CustomImage(
                  imageUrl: 'assets/images/patient.jpg',
                  title: 'Patient',
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            AppText(
              title: "hello,Shahzaib",
            ),
          ],
        ),
      ),
    );
  }
}
