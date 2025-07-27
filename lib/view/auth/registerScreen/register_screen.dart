import 'package:flutter/material.dart';
import 'package:fyp_project/constant/appIcons/app_icon.dart';
import 'package:fyp_project/constant/appImages/app_image.dart';
import 'package:fyp_project/constant/appTextfield/app_textfield.dart';
import 'package:fyp_project/utilis/customFlushbar/customFlashbar.dart'; // Import FlushBar
import 'package:fyp_project/view_modal/provider/textController/text_controller.dart';
import 'package:fyp_project/view_modal/validation/validation.dart';
import 'package:fyp_project/widgets/customImage/custom_image.dart';
import 'package:provider/provider.dart';
import '../../../constant/appAuth/appauth.dart';
import '../../../constant/appButton/app_button.dart';
import '../../../constant/appColors/app_color.dart';
import '../../../constant/appStrings/app_string.dart';
import '../../../navigationScreen/appNavigation.dart';
import '../../../routings/routeName/routes_name.dart';
import '../../../view_modal/provider/generalProvider/general_provider.dart';
import '../../../widgets/customSelectGender/custom_select_gender.dart';

class RegisterScreen extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Consumer<GeneralProvider>(
          builder: (context, reg, child) {
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
                      const SizedBox(height: 40),
                      Center(
                        child: CustomImage(
                          imageUrl: AppImage.projectlogo,
                          imageheight: 120,
                          imagewidth: 120,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
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
                        child: Form(
                          key: formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Appstrings.authRegisterAsPatientText,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 24),
                              AppTextfield(
                                hintText: Appstrings.authRegisterName,
                                controller: TextController.regnameController,
                                prefixIcon: AppIcons.customIcon(Icons.person),
                                suffixIcon: IconButton(
                                  icon: AppIcons.customIcon(Icons.close),
                                  onPressed: () {
                                    TextController.regnameController.clear();
                                  },
                                ),
                                validator: Validators.validateName,
                              ),
                              const SizedBox(height: 18),
                              AppTextfield(
                                hintText: Appstrings.authEmail,
                                controller: TextController.regemailController,
                                prefixIcon: AppIcons.customIcon(Icons.email),
                                validator: Validators.validateEmail,
                              ),
                              const SizedBox(height: 18),
                              AppTextfield(
                                hintText: Appstrings.authPassword,
                                controller: TextController.regpassController,
                                obscureText: reg.isvisible,
                                prefixIcon: AppIcons.customIcon(Icons.lock),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    reg.iconToggle();
                                  },
                                  icon: reg.isvisible
                                      ? AppIcons.customIcon(
                                          Icons.visibility_off)
                                      : AppIcons.customIcon(Icons.visibility),
                                ),
                                validator: Validators.validatePassword,
                              ),
                              const SizedBox(height: 18),
                              AppTextfield(
                                hintText: Appstrings.authRegisterContactNo,
                                controller:
                                    TextController.regContactNoController,
                                prefixIcon: AppIcons.customIcon(
                                    Icons.contact_page_outlined),
                                validator: Validators.validateContact,
                                keyboardType: TextInputType.phone,
                              ),
                              const SizedBox(height: 18),
                              AppTextfield(
                                hintText: Appstrings.authRegisterAge,
                                controller: TextController.regAgeController,
                                prefixIcon: AppIcons.customIcon(Icons.numbers),
                                validator: Validators.validateAge,
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 18),
                              CustomSelectGender(),
                              const SizedBox(height: 28),
                              AppButton(
                                btnText: Appstrings.authRegisterButton,
                                color: AppColors.textbuttoncolor,
                                ontap: () async {
                                  // Validate form first
                                  if (formkey.currentState!.validate()) {
                                    // Validate gender selection separately
                                    if (reg.selectgender == null ||
                                        reg.selectgender!.isEmpty) {
                                      CustomFlushBar.showInfo(
                                          context, "Please select your gender");
                                      return;
                                    }

                                    try {
                                      // Call register method - AppAuth will handle FlushBar and navigation
                                      await AppAuth(context).register();
                                    } catch (e) {
                                      // Only handle exceptions that AppAuth didn't catch
                                      CustomFlushBar.showError(
                                          context, "Error: ${e.toString()}");
                                    }
                                  } else {
                                    // Form validation failed
                                    CustomFlushBar.showInfo(context,
                                        "Please correct the errors in the form");
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      Appstrings.authRegisterAlreadyHaveText,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      AppNavigators.changescreen(
                                          context, RouteName.loginscreen);
                                    },
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        Appstrings.authLoginButton,
                                        style: const TextStyle(
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
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
