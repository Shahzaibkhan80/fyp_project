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
import '../authServices/authservices.dart';

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
  bool otpVerified = false;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
    currentOtp = widget.sentOtp;

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
    final forgot = Provider.of<GeneralProvider>(context, listen: false);
    forgot.stopOtpTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final forgot = Provider.of<GeneralProvider>(context, listen: true);
    final height = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white70 : Colors.black54;
    final cardColor = Theme.of(context).cardColor;
    final bgColor = isDark ? Colors.black : Colors.white;

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: TextStyle(
        fontSize: 20,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textColorGrey),
        borderRadius: BorderRadius.circular(8),
        shape: BoxShape.rectangle,
      ),
    );

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
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
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Center(
                    child: CustomImage(
                      imageUrl: AppImage.projectlogo,
                      imageheight: 130,
                      imagewidth: 130,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          title: Appstrings.authVerificationScreenText,
                          fontSize: 17,
                          color: textColor,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
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
                          separatorBuilder: (index) =>
                              const SizedBox(width: 16),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              title:
                                  Appstrings.authVerificationDontReceiveOtpText,
                              fontSize: 16,
                              color: subTextColor,
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: (!otpVerified && forgot.otpExpired)
                                  ? () async {
                                      final newOtp = await forgot
                                          .sendOtpToEmail(widget.email, "User");
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
                        const SizedBox(height: 24),
                        AppText(
                          title:
                              '00:${forgot.otpSecondsLeft.toString().padLeft(2, '0')}',
                          fontSize: 16,
                          color: forgot.otpExpired
                              ? Colors.red
                              : AppColors.textbuttoncolor,
                        ),
                        const SizedBox(height: 32),
                        AppButton(
                          btnText: Appstrings.authVerificationButton,
                          ontap: () async {
                            if (forgot.otpExpired) {
                              if (!mounted) return;
                              CustomFlushBar.showError(context,
                                  'OTP expired. Please request again.');
                              return;
                            }
                            if (otpController.text == currentOtp) {
                              setState(() {
                                otpVerified = true;
                              });
                              forgot.stopOtpTimer();

                              if (!mounted) return;
                              CustomFlushBar.showSuccess(
                                context,
                                'OTP Verified Successfully!',
                              );

                              final authService = Authservices();
                              final result = await authService
                                  .sendPasswordResetEmail(email: widget.email);

                              if (!mounted) return;
                              if (result == null) {
                                CustomFlushBar.showSuccess(context,
                                    'Password reset link sent to your email!');
                              } else {
                                CustomFlushBar.showError(context,
                                    'Failed to send reset link: $result');
                              }

                              await Future.delayed(const Duration(seconds: 2));
                              if (!mounted) return;
                              AppNavigators.nextscreen(
                                context,
                                RouteName.loginscreen,
                              );
                            } else {
                              if (!mounted) return;
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
