import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fyp_project/view_modal/provider/generalProvider/general_provider.dart';
import 'package:fyp_project/constant/appImages/app_image.dart';
import 'package:fyp_project/utilis/customFlushbar/customFlashbar.dart'; // Import FlushBar

import '../modelPrediction/modelprediction.dart';
import '../profileScreen/profilescreen.dart';

class UploadImage extends StatelessWidget {
  const UploadImage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: Drawer(
          child: ProfileScreen(),
        ),
        appBar: AppBar(
          // backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.blue),
          flexibleSpace: Container(
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
        ),
        body: Consumer<GeneralProvider>(
          builder: (context, provider, child) {
            return Stack(
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
                            Text(
                              "Upload Image",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Select and upload your image for prediction.",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                                fontSize: 16,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 30),

                            // File input row
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(
                                    "File input",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue.shade600,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    icon: const Icon(Icons.file_upload),
                                    onPressed: () async {
                                      try {
                                        await provider.pickImage();
                                        if (provider.selectedImage != null) {
                                          CustomFlushBar.showSuccess(context,
                                              "Image selected successfully!");
                                        }
                                      } catch (e) {
                                        CustomFlushBar.showError(context,
                                            "Failed to select image: ${e.toString()}");
                                      }
                                    },
                                    label: const Text("Choose File"),
                                  ),
                                  const SizedBox(width: 16),
                                  SizedBox(
                                    width: 120,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green.shade600,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: provider.selectedImage != null
                                          ? () async {
                                              try {
                                                CustomFlushBar.showInfo(context,
                                                    "Uploading image...");
                                                await provider
                                                    .uploadImage(context);

                                                // Wait for flushbar to show (e.g. 1 second)
                                                await Future.delayed(
                                                    const Duration(seconds: 1));

                                                CustomFlushBar.showInfo(context,
                                                    "Processing prediction...");
                                                String result = await provider
                                                    .predictImage(context);

                                                await Future.delayed(
                                                    const Duration(seconds: 1));

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Modelprediction(
                                                            predictionResult:
                                                                result),
                                                  ),
                                                );
                                              } catch (e) {
                                                CustomFlushBar.showError(
                                                    context,
                                                    "Upload failed: ${e.toString()}");
                                              }
                                            }
                                          : () {
                                              CustomFlushBar.showInfo(context,
                                                  "Please select an image first");
                                            },
                                      child: const Text("Upload"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),

                            // File name and info
                            Text(
                              provider.selectedImage == null
                                  ? "No file chosen"
                                  : provider.selectedImage!.path
                                      .split('/')
                                      .last,
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.color,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Only image file allowed to upload here.",
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Image preview box
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).dividerColor,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                child: provider.selectedImage == null
                                    ? Center(
                                        child: Text(
                                          "Drop Your Image Here",
                                          style: TextStyle(
                                            color: Theme.of(context).hintColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.file(
                                          provider.selectedImage!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                              ),
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
    );
  }
}
