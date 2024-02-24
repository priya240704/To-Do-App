

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/screens/my_home_page.dart';

class AuthController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> signInUser(
      String name, String email, String password, BuildContext context) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await storeUser(name, email, context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');

        Get.showSnackbar(
          const GetSnackBar(
            // title: '',
            message: 'The account already exists for that email.',
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.to(MyHomePage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.showSnackbar(
          const GetSnackBar(
            // title: '',
            message: 'No user found for that email.',
            duration: Duration(seconds: 2),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.showSnackbar(
          const GetSnackBar(
            // title: '',
            message: 'Wrong password provided for that user.',
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

// store user data email name in firebase
  Future<void> storeUser(
      String name, String email, BuildContext context) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      var user = UserModel(
        name: name,
        email: email,
        profilePic: '',
        uid: uid,
      );
      await firestore.collection('users').doc(uid).set(user.toMap());
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const MyHomePage();
      }));
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Get.showSnackbar(
        GetSnackBar(
          // title: '',
          message: e.message,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Stream<UserModel> getUser() {
    return firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .snapshots()
        .map((event) {
      UserModel userModel = UserModel.fromMap(event.data()!);
      return userModel;
    });
  }
}
