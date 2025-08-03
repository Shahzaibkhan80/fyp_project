import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fyp_project/view_modal/provider/generalProvider/general_provider.dart';
import 'package:fyp_project/constant/appImages/app_image.dart';
import 'package:fyp_project/utilis/customFlushbar/customFlashbar.dart'; // <-- Import FlushBar

import '../../../models/view_report_model.dart';
import '../veiwReport/viewReport.dart';

class Modelprediction extends StatelessWidget {
  final String predictionResult;
  const Modelprediction(
      {super.key, this.predictionResult = "No prediction data"});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
                  // Logo above container (same as login)
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
                        // Heading and subheading inside container (same as login)
                        Text(
                          "Model Prediction",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Your prediction result is shown below.",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontSize: 16,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Content area
                        Expanded(
                          child: Column(
                            children: [
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
                              Text(
                                predictionResult,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 32),
                              SizedBox(
                                width: double.infinity,
                                child: Consumer<GeneralProvider>(
                                  builder: (context, provider, child) {
                                    return ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green.shade600,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                          CustomFlushBar.showSuccess(context,
                                              "PDF generated successfully!");
                                        } catch (e) {
                                          CustomFlushBar.showError(context,
                                              "Failed to generate PDF!");
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: Consumer<GeneralProvider>(
                                  builder: (context, provider, child) {
                                    return ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orange.shade600,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                        final userData =
                                            await provider.getUserData();
                                        if (userData != null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Viewreport(
                                                report: ViewReportModel(
                                                  name: userData['name'] ?? '',
                                                  email:
                                                      userData['email'] ?? '',
                                                  phone:
                                                      userData['contactNo'] ??
                                                          '',
                                                  age: userData['age'] ?? '',
                                                  gender:
                                                      userData['gender'] ?? '',
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
                                    );
                                  },
                                ),
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
          ],
        ),
      ),
    );
  }
}
