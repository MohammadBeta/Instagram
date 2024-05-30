import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/models/user_model.dart';
import 'package:flutter_application_instagram/resources/firebase/auth_metohds.dart';

class UserProvidor with ChangeNotifier {
  UserModel? _user;

  Future<UserModel> getUser() async {
    _user = await AuthMethods().getUser();
    return _user!;
  }
}
