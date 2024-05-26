import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';
import 'package:flutter_application_instagram/core/constants/app_images.dart';
import 'package:flutter_application_instagram/widgets/custom_button.dart';
import 'package:flutter_application_instagram/widgets/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../core/utilis/functions/image_picker.dart';

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
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            SvgPicture.asset(
              instagramLogo,
              color: primaryColor,
            ),
            const SizedBox(
              height: 40,
            ),
            Stack(
              children: [
           CircleAvatar(
  radius: 50,
  backgroundImage: _profileImage != null
      ? MemoryImage(_profileImage!) as ImageProvider
      : const NetworkImage(
          'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg',
        ),
),
                Positioned(
                    bottom: -10,
                    right: -5,
                    child: IconButton(
                        color: primaryColor,
                        onPressed: () async {
                          Uint8List? image =
                              await pickImage(ImageSource.gallery);
                          if (image != null) {
                            setState(() {
                              _profileImage = image;
                            });
                          }
                        },
                        icon: const Icon(Icons.add_a_photo)))
              ],
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
              onTap: () {
                log('SignUp');
              },
              child: const CustomButton(text: "Sign up"),
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("You already have an account? "),
                GestureDetector(
                  onTap: () {
                    log('Log in');
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
      )),
    );
  }
}
