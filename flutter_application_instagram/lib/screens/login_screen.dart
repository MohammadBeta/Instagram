import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';
import 'package:flutter_application_instagram/core/constants/app_images.dart';
import 'package:flutter_application_instagram/resources/firebase/auth_metohds.dart';
import 'package:flutter_application_instagram/screens/signup_screen.dart';
import 'package:flutter_application_instagram/widgets/custom_button.dart';
import 'package:flutter_application_instagram/widgets/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<void> login(BuildContext context) async {
    if (_isLoading) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods().login(
        email: _emailController.text, password: _passwordController.text);

    setState(() {
      _isLoading = false;
    });
    if (result != 'success') {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            result,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Login done successfully',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
        ));
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            InkWell(
              onTap: () async {
                log('Log in');
                await login(context);
              },
              child: CustomButton(
                  widget: _isLoading == false
                      ? const Text("Login")
                      : const CircularProgressIndicator.adaptive()),
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
      )),
    );
  }
}
