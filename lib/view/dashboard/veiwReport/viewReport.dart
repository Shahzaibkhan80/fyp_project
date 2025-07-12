import 'package:flutter/material.dart';
import 'package:fyp_project/models/view_report_model.dart';
import 'package:fyp_project/helper/info_row.dart';

class Viewreport extends StatelessWidget {
  final ViewReportModel report;

  const Viewreport({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
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
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 22),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.assignment_turned_in_rounded,
                                color: Colors.blue.shade700, size: 36),
                            const SizedBox(width: 10),
                            const Text(
                              "Medical Prediction Report",
                              style: TextStyle(
                                color: Color(0xFF1565C0),
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
                      child: Padding(
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Section: Patient Info
                            Row(
                              children: [
                                Icon(Icons.person,
                                    color: Colors.blue.shade400, size: 28),
                                const SizedBox(width: 10),
                                const Text(
                                  "Patient Information",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1565C0),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 28, thickness: 1.2),
                            infoRow("Name", report.name),
                            infoRow("Email", report.email),
                            infoRow("Phone", report.phone),
                            infoRow("Age", report.age),
                            infoRow("Gender", report.gender),
                            const SizedBox(height: 28),
                            // Section: Prediction
                            Row(
                              children: [
                                Icon(Icons.analytics,
                                    color: Colors.green.shade600, size: 28),
                                const SizedBox(width: 10),
                                const Text(
                                  "Prediction Result",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 28, thickness: 1.2),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.green.shade200,
                                  width: 1.2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.green.shade100.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                report.prediction,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1565C0),
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
                      color: Colors.blueGrey.shade700,
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
