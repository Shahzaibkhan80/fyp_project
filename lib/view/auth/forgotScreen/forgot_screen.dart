import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/constant/appButton/app_button.dart';
import 'package:fyp_project/constant/appImages/app_image.dart';
import 'package:fyp_project/constant/appStrings/app_string.dart';
import 'package:fyp_project/constant/appTextfield/app_textfield.dart';
import 'package:fyp_project/view_modal/provider/generalProvider/general_provider.dart';
import 'package:fyp_project/widgets/customImage/custom_image.dart';
import 'package:provider/provider.dart';

import '../../../constant/appColors/app_color.dart';
import '../../../constant/appIcons/app_Icon.dart';
import '../../../utilis/customFlushbar/customFlashbar.dart';
import '../../../view_modal/provider/textController/text_controller.dart';
import '../otpScreen/otpscreen.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white70 : Colors.black54;
    final cardColor = Theme.of(context).cardColor;
    final bgColor = isDark ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: WillPopScope(
        onWillPop: () async {
          TextController.forgotemailController.clear();
          return true;
        },
        child: Stack(
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
            Consumer<GeneralProvider>(
              builder: (context, forgot, child) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      Center(
                        child: CustomImage(
                          imageUrl: AppImage.projectlogo,
                          imageheight: 110,
                          imagewidth: 110,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        width: double.infinity,
                        height: height * 0.80,
                        margin: const EdgeInsets.only(top: 8),
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
                            Text(
                              Appstrings.authForgotPassword,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              Appstrings.authForgotScreenText,
                              style: TextStyle(
                                fontSize: 16,
                                color: subTextColor,
                              ),
                            ),
                            const SizedBox(height: 24),
                            AppTextfield(
                              hintText: Appstrings.authEmail,
                              controller: TextController.forgotemailController,
                              prefixIcon: AppIcons.customIcon(Icons.email),
                            ),
                            const SizedBox(height: 32),
                            AppButton(
                              btnText: Appstrings.authForgorSendButton,
                              ontap: () async {
                                final email = TextController
                                    .forgotemailController.text
                                    .trim();
                                if (email.isEmpty) {
                                  CustomFlushBar.showError(
                                      context, 'Please enter your email');
                                  return;
                                }

                                final userQuery = await FirebaseFirestore
                                    .instance
                                    .collection('users')
                                    .where('email', isEqualTo: email)
                                    .limit(1)
                                    .get();

                                String name = 'User';
                                if (userQuery.docs.isNotEmpty) {
                                  final data = userQuery.docs.first.data();
                                  name = (data.containsKey('name') &&
                                          data['name'] != null &&
                                          data['name']
                                              .toString()
                                              .trim()
                                              .isNotEmpty)
                                      ? data['name']
                                      : 'User';
                                }

                                final otp =
                                    await forgot.sendOtpToEmail(email, name);
                                if (otp != null) {
                                  CustomFlushBar.showSuccess(
                                      context, 'OTP sent to your email!');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Otpscreen(sentOtp: otp, email: email),
                                    ),
                                  );
                                  TextController.forgotemailController.clear();
                                } else {
                                  CustomFlushBar.showError(
                                      context, 'Failed to send OTP');
                                }
                              },
                              color: AppColors.textbuttoncolor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
