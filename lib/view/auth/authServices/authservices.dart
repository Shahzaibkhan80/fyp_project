import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authservices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String?> registerUser({
    required String name,
    required String email,
    required String password,
    required String contactNo,
    required String age,
    required String gender,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = userCredential.user!.uid;

      await firestore.collection('users').doc(uid).set({
        "uid": uid,
        "name": name,
        "email": email,
        "contactNo": contactNo,
        "age": age,
        "gender": gender,
        "createdAt": FieldValue.serverTimestamp(),
      });
      return null;
    } catch (e) {
      print('Error: $e');
      return e.toString();
    }
  }

  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return null;
    } catch (e) {
      print('Error $e');
      return e.toString();
    }
  }
}
