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
import '../authServices/authservices.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: () async {
          TextController.forgotemailController.clear();
          return true; // allow pop
        },
        child: Stack(
          children: [
            // Softer gradient background for better logo visibility
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
                          color: Colors.white,
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
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              Appstrings.authForgotScreenText,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Please enter your email')),
                                  );
                                  return;
                                }
                                final result = await Authservices()
                                    .sendPasswordResetEmail(email: email);
                                if (result == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Reset link sent to your email')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(result)),
                                  );
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
