import 'package:flutter/material.dart';
import 'package:fyp_project/constant/appButton/app_button.dart';
import 'package:fyp_project/constant/appColors/app_color.dart';
import 'package:fyp_project/constant/appStrings/app_string.dart';
import 'package:fyp_project/constant/appText/app_text.dart';
import 'package:fyp_project/constant/appTextfield/app_textfield.dart';
import 'package:fyp_project/view_modal/provider/textController/text_controller.dart';

import '../../../constant/appImages/app_image.dart';
import '../../../widgets/customImage/custom_image.dart';

class Confirmpasswordscreen extends StatelessWidget {
  const Confirmpasswordscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Center(
                  child: CustomImage(
                    imageUrl: AppImage.projectlogo,
                    imageheight: 300,
                    imagewidth: 250,
                  ),
                ),
                SizedBox(height: 20),
                AppText(
                  title: Appstrings.authConfirmPasswordScreenText,
                ),
                SizedBox(height: 10),
                AppTextfield(
                    hintText: Appstrings.authConfirmPasswordNewPassword,
                    controller: TextController.confirmController),
                SizedBox(height: 20),
                AppTextfield(
                    hintText: Appstrings.authCreateNewPasswordText,
                    controller: TextController.confirmnewController),
                SizedBox(height: 40),
                AppButton(
                    btnText: Appstrings.authConfirmPasswordSaveButton,
                    ontap: () {},
                    color: AppColors.textbuttoncolor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
