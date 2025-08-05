import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fyp_project/view_modal/provider/generalProvider/general_provider.dart';
import 'package:fyp_project/constant/appImages/app_image.dart';

import '../../../models/view_report_model.dart';
import '../../../utilis/customFlushbar/customFlashbar.dart';
import '../veiwReport/viewReport.dart';

class Modelprediction extends StatelessWidget {
  final String predictionResult;
  const Modelprediction(
      {super.key, this.predictionResult = "No prediction data"});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final cardColor = Theme.of(context).cardColor;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Gradient background
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Model Prediction",
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Your prediction result is shown below.",
                          style: TextStyle(
                            color: textColor.withOpacity(0.7),
                            fontSize: 16,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 30),
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.blue.shade100,
                          child: Icon(
                            Icons.analytics,
                            size: 38,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 12),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.black12 : Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            predictionResult,
                            style: TextStyle(
                              fontSize: 18,
                              color: textColor,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Consumer<GeneralProvider>(
                          builder: (context, provider, child) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.shade600,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 4,
                                ),
                                icon: const Icon(Icons.picture_as_pdf),
                                label: const Text(
                                  "Generate Report",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  try {
                                    await provider.generatePdf(
                                        context, predictionResult);
                                    CustomFlushBar.showSuccess(
                                        context, "PDF generated successfully!");
                                  } catch (e) {
                                    CustomFlushBar.showError(
                                        context, "Failed to generate PDF!");
                                  }
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Consumer<GeneralProvider>(
                          builder: (context, provider, child) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange.shade600,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 4,
                                ),
                                icon: const Icon(Icons.receipt_long),
                                label: const Text(
                                  "View Report",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  final userData = await provider.getUserData();
                                  if (userData != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Viewreport(
                                          report: ViewReportModel(
                                            name: userData['name'] ?? '',
                                            email: userData['email'] ?? '',
                                            phone: userData['contactNo'] ?? '',
                                            age: userData['age'] ?? '',
                                            gender: userData['gender'] ?? '',
                                            prediction: predictionResult,
                                          ),
                                        ),
                                      ),
                                    );
                                    CustomFlushBar.showSuccess(
                                        context, "Report opened!");
                                  } else {
                                    CustomFlushBar.showError(
                                        context, "User data not found!");
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
