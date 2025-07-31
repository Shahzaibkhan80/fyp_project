import 'package:flutter/material.dart';
import 'package:fyp_project/models/view_report_model.dart';
import 'package:fyp_project/helper/info_row.dart';

class Viewreport extends StatelessWidget {
  final ViewReportModel report;

  const Viewreport({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color predictionBg = isDark
        ? Theme.of(context).colorScheme.surface.withOpacity(0.7)
        : Colors.green.shade50;
    final Color predictionText = isDark ? Colors.greenAccent : Colors.green;

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
                  // Report Title Card
                  Center(
                    child: Card(
                      elevation: 16,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      color: Theme.of(context).cardColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 22),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.assignment_turned_in_rounded,
                              color: predictionText, // Green/dark green
                              size: 36,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Medical Prediction Report",
                              style: TextStyle(
                                color: predictionText, // Green/dark green
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      color: Theme.of(context).cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Section: Patient Info
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: predictionText, // Green/dark green
                                  size: 28,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Patient Information",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: predictionText, // Green/dark green
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 28, thickness: 1.2),
                            infoRow(context, "Name", report.name),
                            infoRow(context, "Email", report.email),
                            infoRow(context, "Phone", report.phone),
                            infoRow(context, "Age", report.age),
                            infoRow(context, "Gender", report.gender),
                            const SizedBox(height: 28),
                            // Section: Prediction
                            Row(
                              children: [
                                Icon(Icons.analytics,
                                    color: predictionText, size: 28),
                                const SizedBox(width: 10),
                                Text(
                                  "Prediction Result",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: predictionText,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 28, thickness: 1.2),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: predictionBg,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: predictionText.withOpacity(0.5),
                                  width: 1.2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: predictionText.withOpacity(0.15),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                report.prediction,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: predictionText,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "Generated by Brain Tumor Detection App",
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
