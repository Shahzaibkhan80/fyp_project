import 'package:flutter/material.dart';
import 'package:fyp_project/constant/appButton/app_button.dart';
import 'package:fyp_project/constant/appColors/app_color.dart';
import 'package:fyp_project/constant/appIcons/app_icon.dart';
import 'package:fyp_project/constant/appStrings/app_string.dart';
import 'package:fyp_project/constant/appText/app_text.dart';
import 'package:fyp_project/constant/appTextfield/app_textfield.dart';
import 'package:fyp_project/navigationScreen/appNavigation.dart';
import 'package:fyp_project/routings/routeName/routes_name.dart';
import 'package:fyp_project/view_modal/provider/generalProvider/general_provider.dart';
import 'package:fyp_project/widgets/customImage/custom_image.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final login = Provider.of<GeneralProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomImage(
                        imageUrl: 'assets/images/doctor.png',
                        title: 'Doctor',
                        imagewidth: 100,
                      ),
                      CustomImage(
                        imageUrl: 'assets/images/patient.jpg',
                        title: 'Patient',
                        imagewidth: 100,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppText(
                      title: Appstrings.authloginText,
                      color: AppColors.blackTextClr,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AppTextfield(
                    labelText: Appstrings.authEmail,
                    controller: login.loginemailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: AppIcons.customIcon(Icons.email),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AppTextfield(
                    controller: login.loginpassController,
                    suffixIcon: AppIcons.suffixIconOff,
                    obscureText: true,
                    labelText: 'Password',
                    prefixIcon: AppIcons.customIcon(Icons.lock),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AppText(
                      title: Appstrings.authForgotPassword,
                      color: AppColors.blackTextClr,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AppButton(
                    btnText: Appstrings.authLoginButton,
                    color: AppColors.textbuttoncolor,
                    ontap: () {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        title: Appstrings.authDontHaveAccount,
                        fontSize: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      AppText(
                        title: Appstrings.authloginReg,
                        fontSize: 16,
                        color: AppColors.textbuttoncolor,
                        ontap: () {
                          AppNavigators.nextscreen(
                              context, RouteName.regscreen);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
