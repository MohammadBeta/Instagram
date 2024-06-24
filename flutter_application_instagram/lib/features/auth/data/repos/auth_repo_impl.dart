import 'dart:typed_data';

import 'package:flutter_application_instagram/core/firebase/auth_metohds.dart';
import 'package:flutter_application_instagram/features/auth/data/repos/auth_repo.dart';

class AuthReplImp extends AuthRepo {
  AuthReplImp({required this.authMethods});
  final AuthMethods authMethods;
  @override
  login({required String email, required String password}) async {
    String result = await authMethods.login(email: email, password: password);

    if (result != 'success') {
      throw Exception(result);
    }
  }

  @override
  signUp(
      {required String email,
      required String password,
      required String userName,
      required String bio,
      required Uint8List? profileImage}) async {
    String result = await authMethods.signUp(
        email: email,
        password: password,
        userName: userName,
        bio: bio,
        profileImage: profileImage);

    if (result != 'success') {
      throw Exception(result);
    }
  }
}
