import 'dart:typed_data';

abstract class AuthRepo {
  login({
    required String email,
    required String password,
  });

  signUp(
      {required String email,
      required String password,
      required String userName,
      required String bio,
      required Uint8List? profileImage});
}
