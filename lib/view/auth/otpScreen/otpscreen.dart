import 'package:flutter/material.dart';
import 'package:fyp_project/constant/appStrings/app_string.dart';
import 'package:fyp_project/constant/appText/app_text.dart';
import 'package:fyp_project/navigationScreen/appNavigation.dart';
import 'package:fyp_project/routings/routeName/routes_name.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../constant/appButton/app_button.dart';
import '../../../constant/appColors/app_color.dart';
import '../../../constant/appImages/app_image.dart';
import '../../../utilis/customFlushbar/customFlashbar.dart';
import '../../../view_modal/provider/generalProvider/general_provider.dart';
import '../../../widgets/customImage/custom_image.dart';

class Otpscreen extends StatefulWidget {
  final String sentOtp;
  final String email;
  Otpscreen({super.key, required this.sentOtp, required this.email});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  late TextEditingController otpController;
  late String currentOtp;
  bool otpVerified = false; // <-- Add this

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
    currentOtp = widget.sentOtp;

    // Post-frame callback me timer start karo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final forgot = Provider.of<GeneralProvider>(context, listen: false);
      forgot.otpTimer?.cancel();
      forgot.otpSecondsLeft = 40;
      forgot.otpExpired = false;
      forgot.startOtpTimer();
    });
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final forgot = Provider.of<GeneralProvider>(context, listen: true);

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
                    controller: otpController,
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
                      GestureDetector(
                        onTap: (!otpVerified && forgot.otpExpired)
                            ? () async {
                                final newOtp = await forgot.sendOtpToEmail(
                                    widget.email, "User");
                                if (newOtp != null) {
                                  setState(() {
                                    currentOtp = newOtp;
                                  });
                                  forgot.otpTimer?.cancel();
                                  forgot.otpSecondsLeft = 40;
                                  forgot.otpExpired = false;
                                  forgot.startOtpTimer();
                                  CustomFlushBar.showSuccess(
                                      context, 'OTP Sent Successfully!');
                                } else {
                                  CustomFlushBar.showError(
                                      context, 'Failed to send OTP');
                                }
                              }
                            : null,
                        child: AppText(
                          title: Appstrings.authVerificationResendText,
                          fontSize: 16,
                          color: (!otpVerified && forgot.otpExpired)
                              ? AppColors.textbuttoncolor
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  AppText(
                    title:
                        '00:${forgot.otpSecondsLeft.toString().padLeft(2, '0')}',
                    fontSize: 16,
                    color: forgot.otpExpired
                        ? Colors.red
                        : AppColors.textbuttoncolor,
                  ),
                  SizedBox(height: 30),
                  AppButton(
                    btnText: Appstrings.authVerificationButton,
                    ontap: () async {
                      if (forgot.otpExpired) {
                        CustomFlushBar.showError(
                            context, 'OTP expired. Please request again.');
                        return;
                      }
                      if (otpController.text == currentOtp) {
                        setState(() {
                          otpVerified = true;
                        });
                        forgot.stopOtpTimer();

                        CustomFlushBar.showSuccess(
                          context,
                          'OTP Verified Successfully!',
                        );

                        await Future.delayed(const Duration(seconds: 2));
                        AppNavigators.nextscreen(
                          context,
                          RouteName.confirmpasswordscreen,
                        );
                      } else {
                        CustomFlushBar.showError(context, 'Invalid OTP');
                      }
                    },
                    color: AppColors.textbuttoncolor,
                  ),
                  if (forgot.otpExpired)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: AppText(
                        title: 'OTP expired. Please request again.',
                        fontSize: 14,
                        color: Colors.red,
                      ),
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
