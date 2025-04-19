import 'package:flutter/material.dart';
import 'package:fyp_project/constant/appButton/app_button.dart';
import 'package:fyp_project/constant/appImages/app_image.dart';
import 'package:fyp_project/constant/appStrings/app_string.dart';
import 'package:fyp_project/constant/appText/app_text.dart';
import 'package:fyp_project/constant/appTextfield/app_textfield.dart';
import 'package:fyp_project/view_modal/provider/generalProvider/general_provider.dart';
import 'package:fyp_project/widgets/customImage/custom_image.dart';
import 'package:provider/provider.dart';

import '../../../constant/appColors/app_color.dart';
import '../../../constant/appIcons/app_Icon.dart';
import '../../../view_modal/provider/textController/text_controller.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GeneralProvider>(
        builder: (context, forgot, child) {
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CustomImage(
                      imageUrl: AppImage.projectlogo,
                      imageheight: 300,
                      imagewidth: 250,
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppText(
                        title: Appstrings.authForgotPassword,
                        color: AppColors.blackTextClr,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppText(
                        title: Appstrings.authForgotScreenText,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    AppTextfield(
                      hintText: Appstrings.authEmail,
                      controller: TextController.loginemailController,
                      prefixIcon: AppIcons.customIcon(Icons.email),
                    ),
                    SizedBox(height: 80),
                    AppButton(
                      btnText: Appstrings.authForgorSendButton,
                      ontap: () {},
                      color: AppColors.textbuttoncolor,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
