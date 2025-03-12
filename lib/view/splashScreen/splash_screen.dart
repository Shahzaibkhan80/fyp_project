import 'package:flutter/material.dart';
import 'package:fyp_project/constant/appColors/app_color.dart';
import 'package:fyp_project/constant/appImages/app_image.dart';
import 'package:fyp_project/view_modal/provider/generalProvider/general_provider.dart';
import 'package:fyp_project/widgets/customImage/custom_image.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<GeneralProvider>(context, listen: true).setLoading(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CustomImage(
              imageUrl: AppImage.projectlogo,
              imageheight: screenHeight * 0.9,
              imagewidth: screenWidth * 0.9,
            ),
          ),
          const CircularProgressIndicator(
            color: AppColors.textbuttoncolor,
          ),
        ],
      ),
    );
  }
}
