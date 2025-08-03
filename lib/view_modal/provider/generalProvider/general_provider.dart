// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img; // <-- Only this for image ops
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_file/open_file.dart';

import '../../../utilis/customFlushbar/customFlashbar.dart';

class GeneralProvider extends ChangeNotifier {
  // Splash Screen Working
  void setLoading(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/RegisterScreen');
    });
  }

  // Select Gender
  String? selectgender;
  void setGender(String gender) {
    selectgender = gender;
    notifyListeners();
  }

  // Textfield visibility
  bool isvisible = true;
  void iconToggle() {
    isvisible = !isvisible;
    notifyListeners();
  }

  // Image upload functionality
  File? selectedImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selected_image_path', pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> uploadImage(BuildContext context) async {
    if (selectedImage == null) return;
    // Yahan apni upload logic lagayen (API call, Firebase, etc.)
    CustomFlushBar.showSuccess(context, 'Image uploaded!');
  }

  Interpreter? _interpreter;

  Future<void> loadModel() async {
    try {
      print('Loading model...');
      _interpreter = await Interpreter.fromAsset('assets/braintumor.tflite');
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

  Future<String> predictImage(BuildContext context) async {
    print('Prediction started...');
    if (selectedImage == null) {
      print('No image selected');
      return "No image selected";
    }
    if (_interpreter == null) {
      print('Interpreter is null, loading model...');
      await loadModel();
    }

    // 1. Read image file and decode
    print('Reading image file...');
    final bytes = await selectedImage!.readAsBytes();
    img.Image? image = img.decodeImage(bytes);
    if (image == null) {
      print('Invalid image');
      return "Invalid image";
    }
    print('Image decoded!');

    // 2. Resize to 150x150
    print('Resizing image...');
    img.Image resized = img.copyResize(image, width: 150, height: 150);
    print('Image resized!');

    // 3. Normalize (0-1 range, float32)
    print('Normalizing image...');
    List<double> input = [];
    for (int y = 0; y < 150; y++) {
      for (int x = 0; x < 150; x++) {
        final r = resized.getPixel(x, y).r;
        final g = resized.getPixel(x, y).g;
        final b = resized.getPixel(x, y).b;
        input.add(r / 255.0);
        input.add(g / 255.0);
        input.add(b / 255.0);
      }
    }
    print('Image normalized!');

    // 4. Model input shape: [1, 150, 150, 3]
    print('Preparing input tensor...');
    var inputTensor = input.reshape([1, 150, 150, 3]);
    var output = List.filled(4, 0.0).reshape([1, 4]);
    print('Running model...');
    _interpreter!.run(inputTensor, output);
    print('Model run complete!');

    // 5. Output decode (same as Python)
    List<String> labels = ['Glioma', 'Meningioma', 'No Tumor', 'Pituitary'];
    int classIndex = 0;
    double maxScore = output[0][0];
    for (int i = 1; i < 4; i++) {
      if (output[0][i] > maxScore) {
        maxScore = output[0][i];
        classIndex = i;
      }
    }
    String label = labels[classIndex];
    double confidence = maxScore * 100;

    return "$label (${confidence.toStringAsFixed(2)}%)";
  }

  Future<void> generatePdf(
      BuildContext context, String predictionResult) async {
    final pdf = pw.Document();

    // Load Raleway-MediumItalic font
    final fontData =
        await rootBundle.load("assets/fonts/Raleway-MediumItalic.ttf");
    final ralewayFont = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.Page(
        build: (pw.Context ctx) => pw.Center(
          child: pw.Column(
            children: [
              pw.Text('Model Prediction Report',
                  style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      font: ralewayFont)),
              pw.SizedBox(height: 20),
              pw.Text(predictionResult,
                  style: pw.TextStyle(fontSize: 18, font: ralewayFont)),
            ],
          ),
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/prediction_report.pdf');
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('PDF Report saved: ${file.path}'),
        action: SnackBarAction(
          label: 'Open',
          onPressed: () {
            OpenFile.open(file.path);
          },
        ),
      ),
    );
  }

  //theme mode
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  //-------------------get user from firebase-------------------
  Future<Map<String, dynamic>?> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    return doc.data();
  }
}
