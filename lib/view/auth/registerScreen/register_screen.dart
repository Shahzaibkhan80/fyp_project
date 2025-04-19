import 'package:flutter/material.dart';
import 'package:fyp_project/constant/appIcons/app_icon.dart';
import 'package:fyp_project/constant/appImages/app_image.dart';
import 'package:fyp_project/constant/appTextfield/app_textfield.dart';
import 'package:fyp_project/view/auth/authServices/authservices.dart';
import 'package:fyp_project/view_modal/provider/textController/text_controller.dart';
import 'package:fyp_project/widgets/customImage/custom_image.dart';
import 'package:provider/provider.dart';
import '../../../constant/appAuth/appauth.dart';
import '../../../constant/appButton/app_button.dart';
import '../../../constant/appColors/app_color.dart';
import '../../../constant/appStrings/app_string.dart';
import '../../../constant/appText/app_text.dart';
import '../../../view_modal/provider/generalProvider/general_provider.dart';
import '../../../widgets/customSelectGender/custom_select_gender.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<GeneralProvider>(
          builder: (context, reg, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Center(
                      child: CustomImage(
                        imageUrl: AppImage.projectlogo,
                        imageheight: 200,
                        imagewidth: 200,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppText(
                        title: Appstrings.authRegisterAsPatientText,
                        color: AppColors.blackTextClr,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    AppTextfield(
                      hintText: Appstrings.authRegisterName,
                      controller: TextController.regnameController,
                      prefixIcon: AppIcons.customIcon(Icons.person),
                      suffixIcon: AppIcons.customIcon(Icons.close),
                    ),
                    SizedBox(height: 10),
                    AppTextfield(
                      hintText: Appstrings.authEmail,
                      controller: TextController.regemailController,
                      prefixIcon: AppIcons.customIcon(Icons.email),
                    ),
                    SizedBox(height: 10),
                    AppTextfield(
                      hintText: Appstrings.authPassword,
                      controller: TextController.regpassController,
                      obscureText: true,
                      prefixIcon: AppIcons.customIcon(Icons.lock_open_rounded),
                    ),
                    SizedBox(height: 10),
                    AppTextfield(
                      hintText: Appstrings.authRegisterContactNo,
                      controller: TextController.regContactNoController,
                      prefixIcon:
                          AppIcons.customIcon(Icons.contact_page_outlined),
                    ),
                    SizedBox(height: 10),
                    AppTextfield(
                      hintText: Appstrings.authRegisterAge,
                      controller: TextController.regAgeController,
                      prefixIcon: AppIcons.customIcon(Icons.numbers),
                    ),
                    SizedBox(height: 10),
                    CustomSelectGender(),
                    SizedBox(
                      height: 30,
                    ),
                    AppButton(
                        btnText: Appstrings.authRegisterButton,
                        color: AppColors.textbuttoncolor,
                        ontap: () {
                          AppAuth(context).register();
                        }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
