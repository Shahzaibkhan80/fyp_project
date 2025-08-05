import 'package:flutter/material.dart';
import 'package:fyp_project/constant/appButton/app_button.dart';
import 'package:fyp_project/constant/appColors/app_color.dart';
import 'package:fyp_project/constant/appStrings/app_string.dart';
import 'package:fyp_project/constant/appText/app_text.dart';
import 'package:fyp_project/constant/appTextfield/app_textfield.dart';
import 'package:fyp_project/view_modal/provider/textController/text_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../../utilis/customFlushbar/customFlashbar.dart';
import '../../../constant/appImages/app_image.dart';
import '../../../view_modal/provider/generalProvider/general_provider.dart';
import '../../../widgets/customImage/custom_image.dart';
import 'package:fyp_project/view_modal/validation/validation.dart';

class Confirmpasswordscreen extends StatelessWidget {
  const Confirmpasswordscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final bgColor = isDark ? Colors.black : Colors.white;
    final cardColor = Theme.of(context).cardColor;

    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor, // <-- yahan bgColor use karo
        body: WillPopScope(
          onWillPop: () async {
            TextController.loginemailController.clear();
            TextController.loginpassController.clear();
            return true;
          },
          child: Consumer<GeneralProvider>(
            builder: (context, cf, child) {
              return Stack(
                children: [
                  // Blue gradient background
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 141, 176, 216),
                          Color.fromARGB(255, 118, 167, 231),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        Center(
                          child: Image.asset(
                            AppImage.projectlogo,
                            height: 130,
                            width: 130,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Container(
                          width: double.infinity,
                          height: height * 0.76,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 32),
                          decoration: BoxDecoration(
                            color: cardColor, // Theme card color
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(36),
                              topRight: Radius.circular(36),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.08),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              AppText(
                                title: Appstrings.authConfirmPasswordScreenText,
                                color: textColor,
                              ),
                              SizedBox(height: 10),
                              AppTextfield(
                                hintText:
                                    Appstrings.authConfirmPasswordNewPassword,
                                controller: TextController.confirmController,
                              ),
                              SizedBox(height: 20),
                              AppTextfield(
                                hintText: Appstrings.authCreateNewPasswordText,
                                controller: TextController.confirmnewController,
                              ),
                              SizedBox(height: 40),
                              AppButton(
                                btnText:
                                    Appstrings.authConfirmPasswordSaveButton,
                                color: AppColors.textbuttoncolor,
                                ontap: () async {
                                  final newPassword = TextController
                                      .confirmController.text
                                      .trim();
                                  final confirmPassword = TextController
                                      .confirmnewController.text
                                      .trim();

                                  // Validators ka use
                                  final passwordError =
                                      Validators.validatePassword(newPassword);
                                  if (passwordError != null) {
                                    CustomFlushBar.showError(
                                        context, passwordError);
                                    return;
                                  }
                                  if (newPassword != confirmPassword) {
                                    CustomFlushBar.showError(
                                        context, 'Passwords do not match');
                                    return;
                                  }

                                  try {
                                    final user =
                                        FirebaseAuth.instance.currentUser;
                                    if (user != null) {
                                      await user.updatePassword(newPassword);
                                      CustomFlushBar.showSuccess(context,
                                          'Password updated successfully!');
                                      await Future.delayed(
                                          const Duration(seconds: 2));
                                      Navigator.of(context)
                                          .pushReplacementNamed('/LoginScreen');
                                    } else {
                                      CustomFlushBar.showError(
                                          context, 'No user found');
                                    }
                                  } catch (e) {
                                    CustomFlushBar.showError(
                                        context, 'Failed to update password');
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
