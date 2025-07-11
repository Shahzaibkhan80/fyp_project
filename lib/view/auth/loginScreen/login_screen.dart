import 'package:flutter/material.dart';
import 'package:fyp_project/constant/appAuth/appauth.dart';
import 'package:fyp_project/constant/appColors/app_color.dart';
import 'package:fyp_project/constant/appIcons/app_icon.dart';
import 'package:fyp_project/constant/appStrings/app_string.dart';
import 'package:fyp_project/constant/appTextfield/app_textfield.dart';
import 'package:fyp_project/navigationScreen/appNavigation.dart';
import 'package:fyp_project/routings/routeName/routes_name.dart';
import 'package:fyp_project/view_modal/provider/generalProvider/general_provider.dart';
import 'package:fyp_project/view_modal/validation/validation.dart';
import 'package:provider/provider.dart';

import '../../../constant/appButton/app_button.dart';
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
            return true; // allow pop
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
                          Color(0xFF1565C0),
                          Color(0xFF42A5F5),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 80),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 24, bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Welcome",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  Appstrings.authloginText,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: height * 0.76,
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
                              Form(
                                key: formkey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 30),
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
                                    // Gradient Button
                                    AppButton(
                                      btnText: Appstrings.authLoginButton,
                                      color: const Color(0xFF1565C0),
                                      ontap: () {
                                        if (formkey.currentState!.validate()) {
                                          AppAuth(context).login();
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
                                        color: Colors.grey,
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
