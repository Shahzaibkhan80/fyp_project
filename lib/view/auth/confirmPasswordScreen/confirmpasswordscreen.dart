import 'package:flutter/material.dart';
import 'package:fyp_project/constant/appButton/app_button.dart';
import 'package:fyp_project/constant/appColors/app_color.dart';
import 'package:fyp_project/constant/appStrings/app_string.dart';
import 'package:fyp_project/constant/appText/app_text.dart';
import 'package:fyp_project/constant/appTextfield/app_textfield.dart';
import 'package:fyp_project/view_modal/provider/textController/text_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../../constant/appImages/app_image.dart';
import '../../../view_modal/provider/generalProvider/general_provider.dart';
import 'package:fyp_project/view_modal/validation/validation.dart';
import '../../../utilis/customFlushbar/customFlashbar.dart';

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
        backgroundColor: bgColor,
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
                            color: cardColor,
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
                              const SizedBox(height: 20),
                              AppText(
                                title: Appstrings.authConfirmPasswordScreenText,
                                color: textColor,
                              ),
                              const SizedBox(height: 10),
                              AppTextfield(
                                hintText: "Enter Old Password",
                                controller: TextController.confirmController,
                                obscureText: !cf.isOldVisible,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    cf.isOldVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    cf.toggleOldVisible();
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              AppTextfield(
                                hintText: "Enter New Password",
                                controller: TextController.confirmnewController,
                                obscureText: !cf.isNewVisible,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    cf.isNewVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    cf.toggleNewVisible();
                                  },
                                ),
                              ),
                              const SizedBox(height: 40),
                              AppButton(
                                btnText:
                                    Appstrings.authConfirmPasswordSaveButton,
                                color: AppColors.textbuttoncolor,
                                ontap: () async {
                                  final oldPassword = TextController
                                      .confirmController.text
                                      .trim();
                                  final newPassword = TextController
                                      .confirmnewController.text
                                      .trim();

                                  // Validation
                                  if (oldPassword.isEmpty ||
                                      newPassword.isEmpty) {
                                    CustomFlushBar.showError(
                                        context, "Please fill all fields");
                                    return;
                                  }
                                  final passwordError =
                                      Validators.validatePassword(newPassword);
                                  if (passwordError != null) {
                                    CustomFlushBar.showError(
                                        context, passwordError);
                                    return;
                                  }
                                  if (oldPassword == newPassword) {
                                    CustomFlushBar.showError(context,
                                        "New password must be different from old password");
                                    return;
                                  }

                                  try {
                                    final user =
                                        FirebaseAuth.instance.currentUser;
                                    final email = user?.email;
                                    if (user != null && email != null) {
                                      // Re-authenticate user
                                      final cred = EmailAuthProvider.credential(
                                        email: email,
                                        password: oldPassword,
                                      );
                                      await user
                                          .reauthenticateWithCredential(cred);

                                      // Update password
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
                                    CustomFlushBar.showError(context,
                                        'Old password is incorrect or update failed');
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
