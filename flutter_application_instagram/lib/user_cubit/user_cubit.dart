import 'package:flutter_application_instagram/core/firebase/auth_metohds.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/firebase/firestore_methods.dart';
import '../models/user_model.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.authMethods}) : super(UserInitial());
  final AuthMethods authMethods;
  UserModel? _user;
  UserModel get user => _user!;

  Future<void> refreshUser() async {
    _user = await authMethods.getUser();
  }

  Future<UserModel> getUserByUid(String uid) async {
    _user = await FireStoreMethods().getUserByUid(uid);
    return _user!;
  }

}
