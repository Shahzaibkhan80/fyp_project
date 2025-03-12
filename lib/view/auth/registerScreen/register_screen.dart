import 'package:flutter/material.dart';
import 'package:fyp_project/constant/appIcons/app_icon.dart';
import 'package:fyp_project/constant/appImages/app_image.dart';
import 'package:fyp_project/constant/appTextfield/app_textfield.dart';
import 'package:fyp_project/widgets/customImage/custom_image.dart';
import 'package:provider/provider.dart';
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
            return Padding(
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
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 20),
                  AppTextfield(
                    labelText: Appstrings.authRegisterName,
                    controller: reg.regnameController,
                    prefixIcon: AppIcons.customIcon(Icons.person),
                  ),
                  SizedBox(height: 10),
                  AppTextfield(
                    labelText: Appstrings.authEmail,
                    controller: reg.loginemailController,
                    prefixIcon: AppIcons.customIcon(Icons.email),
                  ),
                  SizedBox(height: 10),
                  AppTextfield(
                    labelText: Appstrings.authPassword,
                    controller: reg.loginpassController,
                    prefixIcon: AppIcons.customIcon(Icons.lock_open_rounded),
                  ),
                  SizedBox(height: 10),
                  AppTextfield(
                    labelText: Appstrings.authRegisterContactNo,
                    controller: reg.regContactNoController,
                    prefixIcon:
                        AppIcons.customIcon(Icons.contact_page_outlined),
                  ),
                  SizedBox(height: 10),
                  AppTextfield(
                    labelText: Appstrings.authRegisterAge,
                    controller: reg.loginpassController,
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
                    ontap: () {},
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
