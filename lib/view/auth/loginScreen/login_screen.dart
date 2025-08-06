import 'package:flutter/material.dart';
import 'package:fyp_project/constant/appAuth/appauth.dart';
import 'package:fyp_project/constant/appColors/app_color.dart';
import 'package:fyp_project/constant/appIcons/app_icon.dart';
import 'package:fyp_project/constant/appStrings/app_string.dart';
import 'package:fyp_project/constant/appTextfield/app_textfield.dart';
import 'package:fyp_project/navigationScreen/appNavigation.dart';
import 'package:fyp_project/routings/routeName/routes_name.dart';
import 'package:fyp_project/utilis/customFlushbar/customFlashbar.dart';
import 'package:fyp_project/view_modal/provider/generalProvider/general_provider.dart';
import 'package:fyp_project/view_modal/validation/validation.dart';
import 'package:provider/provider.dart';

import '../../../constant/appButton/app_button.dart';
import '../../../constant/appImages/app_image.dart';
import '../../../view_modal/provider/textController/text_controller.dart';

class LoginScreen extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: WillPopScope(
          onWillPop: () async {
            TextController.loginemailController.clear();
            TextController.loginpassController.clear();
            return true;
          },
          child: Consumer<GeneralProvider>(
            builder: (context, login, child) {
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
                        // Logo above container
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
                            color: Theme.of(context).cardColor,
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
                              // Heading and subheading inside container
                              Text(
                                "Welcome",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                Appstrings.authloginText,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color, // Theme color use karein
                                  fontSize: 24,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Form(
                                key: formkey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextfield(
                                      hintText: Appstrings.authEmail,
                                      controller:
                                          TextController.loginemailController,
                                      keyboardType: TextInputType.emailAddress,
                                      prefixIcon: AppIcons.customIcon(
                                          Icons.email_outlined),
                                      validator: Validators.validateEmail,
                                    ),
                                    const SizedBox(height: 20),
                                    AppTextfield(
                                      controller:
                                          TextController.loginpassController,
                                      obscureText: login.isvisible,
                                      hintText: Appstrings.authPassword,
                                      prefixIcon: AppIcons.customIcon(
                                          Icons.lock_outline),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          login.iconToggle();
                                        },
                                        icon: login.isvisible
                                            ? AppIcons.customIcon(
                                                Icons.visibility_off_outlined)
                                            : AppIcons.customIcon(
                                                Icons.visibility_outlined),
                                      ),
                                      validator: Validators.validatePassword,
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            AppNavigators.nextscreen(context,
                                                RouteName.forgotscreen);
                                          },
                                          child: Text(
                                            Appstrings.authForgotPassword,
                                            style: TextStyle(
                                              color: AppColors.textbuttoncolor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                    // Gradient Button with CustomFlushBar
                                    AppButton(
                                      btnText: Appstrings.authLoginButton,
                                      color: const Color(0xFF1565C0),
                                      ontap: () async {
                                        if (formkey.currentState!.validate()) {
                                          final result =
                                              await AppAuth(context).login();
                                          if (result == null) {
                                            CustomFlushBar.showSuccess(
                                                context, "Login successful!");
                                            await Future.delayed(
                                                const Duration(seconds: 2));
                                            if (context.mounted) {
                                              AppNavigators.nextscreen(context,
                                                  RouteName.uploadimage);
                                            }
                                          } else {
                                            CustomFlushBar.showError(
                                                context, result);
                                          }
                                        } else {
                                          CustomFlushBar.showInfo(context,
                                              "Please correct the form errors.");
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      Appstrings.authDontHaveAccount,
                                      style: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  GestureDetector(
                                    onTap: () {
                                      AppNavigators.nextscreen(
                                          context, RouteName.regscreen);
                                    },
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        Appstrings.authRegisterButton,
                                        style: TextStyle(
                                          color: Color(0xFF1565C0),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
