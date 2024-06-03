import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/models/user_model.dart';
import 'package:flutter_application_instagram/resources/firebase/auth_metohds.dart';
import 'package:flutter_application_instagram/resources/firebase/firestore_methods.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  UserModel get user => _user!;
  Future<UserModel> refreshUser() async {
    _user = await AuthMethods().getUser();
    return _user!;
  }
    Future<UserModel> getUserByUid(String uid) async {
    _user = await FireStoreMethods().getUserByUid(uid);
    return _user!;
  }
}
