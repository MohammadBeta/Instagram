import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_instagram/models/user_model.dart';
import 'package:flutter_application_instagram/core/firebase/firestore_methods.dart';
import 'package:flutter_application_instagram/core/firebase/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> signUp(
      {required String email,
      required String password,
      required String userName,
      required String bio,
      required Uint8List? profileImage}) async {
    String result = "an error has occured";
    if (email.isEmpty || password.isEmpty || userName.isEmpty) {
      result = 'Please check fields input first';
      return result;
    }
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      String profileImageUrl = '';
      if (profileImage != null) {
        profileImageUrl = await FirebaseStorageMethods()
            .uploadFile('ProfilePicture', profileImage);
      }
      UserModel user = UserModel(
          userUid: userCredential.user!.uid,
          email: email,
          userName: userName,
          bio: bio,
          profileImageUrl: profileImageUrl,
          followers: [],
          following: []);

      await FireStoreMethods()
          .addDocument('users', user.userUid, user.toJosn());

      result = "success";
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        result = 'Email is already exists';
      } else if (error.code == 'operation-not-allowed') {
        result = 'Your email is not activated yet';
      } else if (error.code == 'invalid-email') {
        result = 'Invaild email';
      } else if (error.code == 'weak-password') {
        result = 'Password is weak';
      } else {
        result = error.code.toString();
      }
    } catch (ex) {
      result = ex.toString();
    }

    log(result);
    return result;
  }

  Future<String> login(
      {required String email, required String password}) async {
    String result = "an error has occured";
    if (email.isEmpty || password.isEmpty) {
      result = 'Please check fields input first';
      return result;
    }
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      result = "success";
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        result = 'Email is not exists';
      } else if (error.code == 'user-disabled') {
        result = 'Your email is not activated yet';
      } else if (error.code == 'invalid-email') {
        result = 'Invaild email';
      } else if (error.code == 'wrong-password') {
        result = 'Please check your password';
      } else if (error.code == 'invalid-credential') {
        result = 'Email or password is not correct';
      } else {
        result = error.code.toString();
      }
    } catch (ex) {
      result = ex.toString();
    }

    log(result);
    return result;
  }

  Future<UserModel> getUser() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return UserModel.formSnap(doc);
  }
}
