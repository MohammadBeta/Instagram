import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';
import 'package:flutter_application_instagram/core/constants/app_images.dart';
import 'package:flutter_application_instagram/core/firebase/auth_metohds.dart';
import 'package:flutter_application_instagram/core/widgets/custom_button.dart';
import 'package:flutter_application_instagram/core/widgets/custom_text_field.dart';
import 'package:flutter_application_instagram/features/auth/data/repos/auth_repo_impl.dart';
import 'package:flutter_application_instagram/features/auth/presentation/manage/auth_cubit/auth_cubit.dart';
import 'package:flutter_application_instagram/features/auth/presentation/manage/auth_cubit/auth_state.dart';
import 'package:flutter_application_instagram/features/auth/presentation/views/signup_screen.dart';
import 'package:flutter_application_instagram/features/home/pesentation/views/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
        create: (context) =>
            AuthCubit(authReplImpl: AuthReplImp(authMethods: AuthMethods())),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                instagramLogo,
                color: primaryColor,
              ),
              const SizedBox(
                height: 40,
              ),
              CustomTextField(
                editingController: _emailController,
                hintText: "Enter your email",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              CustomTextField(
                editingController: _passwordController,
                hintText: "Enter your password",
                isPassword: true,
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is LoginFauiler) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.red,
                    ));
                  } else if (state is LoginSuccess) {
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const HomeScreen()));
                  }
                },
                builder: (context, state) {
                  return InkWell(
                    onTap: () async {
                      log('Log in');
                      BlocProvider.of<AuthCubit>(context).login(
                          email: _emailController.text,
                          password: _passwordController.text);
                    },
                    child: CustomButton(
                        widget: state is LoginLoading
                            ? const CircularProgressIndicator.adaptive()
                            : const Text("Login")),
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      log('Navigate To Sign up Screen');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
