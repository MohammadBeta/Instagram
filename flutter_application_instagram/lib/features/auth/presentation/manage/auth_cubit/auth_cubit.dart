import 'dart:typed_data';

import 'package:flutter_application_instagram/features/auth/presentation/manage/auth_cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/auth_repo_impl.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authReplImpl}) : super(AuthInitial());
  final AuthReplImp authReplImpl;
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await authReplImpl.login(email: email, password: password);
      emit(LoginSuccess());
    } catch (ex) {
      emit(LoginFauiler(errorMessage: ex.toString()));
    }
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String userName,
      required String bio,
      required Uint8List? profileImage}) async {
    emit(SignUpLoading());
    try {
     await authReplImpl.signUp(
          email: email,
          password: password,
          userName: userName,
          bio: bio,
          profileImage: profileImage);
      emit(SignUpSuccess());
    } catch (ex) {
      emit(SignUpFauiler(errorMessage: ex.toString()));
    }
  }
}
