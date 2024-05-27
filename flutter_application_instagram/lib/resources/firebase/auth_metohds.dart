import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_instagram/resources/firebase/firestore_methods.dart';
import 'package:flutter_application_instagram/resources/firebase/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> signUp(
      {required String email,
      required String password,
      required String userName,
      required String bio,
      required Uint8List? profileImage}) async {
    String result = "an error has occured";
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      String userUid = userCredential.user!.uid;
      String profileImageUrl = '';
      if (profileImage != null) {
        profileImageUrl = await FirebaseStorageMethods()
            .uploadFile('ProfilePicture', profileImage);
      }

      await FireStoreMethods().addDocument('users', userUid, {
        'uid': userUid,
        'email': email,
        'userName': userName,
        'bio': bio,
        'ProfileImageUrl': profileImageUrl,
        'followers': [],
        'following': []
      });

      result = "success";
    } catch (ex) {
      result = ex.toString();
    }

    log(result);
    return result;
  }
}
