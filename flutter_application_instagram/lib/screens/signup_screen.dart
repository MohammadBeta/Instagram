import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';
import 'package:flutter_application_instagram/core/constants/app_images.dart';
import 'package:flutter_application_instagram/screens/login_screen.dart';
import 'package:flutter_application_instagram/widgets/custom_button.dart';
import 'package:flutter_application_instagram/widgets/custom_text_field.dart';
import 'package:flutter_application_instagram/widgets/profile_image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../core/utilis/functions/image_picker.dart';
import '../resources/firebase/auth_metohds.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _profileImage;
  bool _isLoading = false;
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

  Future<void> pickProfileImage() async {
    Uint8List? image = await pickImage(ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = image;
      });
    }
  }

  Future<void> signUp(BuildContext context) async {
    if (_isLoading == true) {
      return;
    }
    setState(
      () {
        _isLoading = true;
      },
    );
    String result = await AuthMethods().signUp(
        email: _emailController.text,
        password: _passwordController.text,
        userName: _userNameController.text,
        bio: _bioController.text,
        profileImage: _profileImage);
    setState(
      () {
        _isLoading = false;
      },
    );
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
          content: Text('Sign up done successfully',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                instagramLogo,
                color: primaryColor,
              ),
              const SizedBox(
                height: 40,
              ),
              ProfileImagePicker(
                onPressed: () async {
                  await pickProfileImage();
                },
                image: _profileImage,
              ),
              const SizedBox(
                height: 24,
              ),
              CustomTextField(
                editingController: _userNameController,
                hintText: "Enter your user name",
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
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
              CustomTextField(
                editingController: _bioController,
                hintText: "Enter your bio",
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () async {
                  log('SignUp');
                  await signUp(context);
                },
                child: CustomButton(
                    widget: _isLoading == false
                        ? const Text("Sign up")
                        : const CircularProgressIndicator.adaptive()),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You already have an account? "),
                  GestureDetector(
                    onTap: () {
                      log('Navigate To Login Screen');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      "Log in",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
