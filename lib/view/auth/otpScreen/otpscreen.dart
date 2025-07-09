import 'package:flutter/material.dart';
import 'package:fyp_project/constant/appStrings/app_string.dart';
import 'package:fyp_project/constant/appText/app_text.dart';
import 'package:fyp_project/navigationScreen/appNavigation.dart';
import 'package:fyp_project/routings/routeName/routes_name.dart';
import 'package:pinput/pinput.dart';

import '../../../constant/appButton/app_button.dart';
import '../../../constant/appColors/app_color.dart';
import '../../../constant/appImages/app_image.dart';
import '../../../widgets/customImage/custom_image.dart';

class Otpscreen extends StatelessWidget {
  const Otpscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: TextStyle(
        fontSize: 20,
        color: AppColors.blackTextClr,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textColorGrey),
        borderRadius: BorderRadius.circular(8),
        shape: BoxShape.rectangle,
      ),
    );
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImage(
                  imageUrl: AppImage.projectlogo,
                  imageheight: 300,
                  imagewidth: 250,
                ),
                // SizedBox(height: 5),
                SizedBox(
                  width: 300,
                  child: AppText(
                    title: Appstrings.authVerificationScreenText,
                    fontSize: 17,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40),
                Pinput(
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration?.copyWith(
                      border: Border.all(
                        color: AppColors.textbuttoncolor,
                        width: 2,
                      ),
                    ),
                  ),
                  separatorBuilder: (index) => SizedBox(width: 16),
                ),

                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      title: Appstrings.authVerificationDontReceiveOtpText,
                      fontSize: 16,
                    ),
                    SizedBox(width: 5),
                    AppText(
                      title: Appstrings.authVerificationResendText,
                      fontSize: 16,
                      color: AppColors.textbuttoncolor,
                    ),
                  ],
                ),
                SizedBox(height: 30),
                AppText(
                  title: '00:30',
                  fontSize: 16,
                  color: AppColors.textbuttoncolor,
                ),
                SizedBox(height: 30),
                AppButton(
                  btnText: Appstrings.authVerificationButton,
                  ontap: () {
                    AppNavigators.nextscreen(
                        context, RouteName.confirmpasswordscreen);
                  },
                  color: AppColors.textbuttoncolor,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
