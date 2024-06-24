import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';
import 'package:flutter_application_instagram/core/constants/app_images.dart';
import 'package:flutter_application_instagram/core/firebase/auth_metohds.dart';
import 'package:flutter_application_instagram/core/widgets/custom_button.dart';
import 'package:flutter_application_instagram/core/widgets/custom_text_field.dart';
import 'package:flutter_application_instagram/features/auth/data/repos/auth_repo_impl.dart';
import 'package:flutter_application_instagram/features/auth/presentation/manage/auth_cubit/auth_cubit.dart';
import 'package:flutter_application_instagram/features/auth/presentation/manage/auth_cubit/auth_state.dart';
import 'package:flutter_application_instagram/features/auth/presentation/views/login_screen.dart';
import 'package:flutter_application_instagram/features/auth/presentation/widgets/profile_image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utilis/functions/image_picker.dart';
import '../../../home/pesentation/views/home_screen.dart';

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

  Future<void> pickProfileImage() async {
    Uint8List? image = await pickImage(ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
        create: (context) =>
            AuthCubit(authReplImpl: AuthReplImp(authMethods: AuthMethods())),
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
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is SignUpFauiler) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.errorMessage),
                        backgroundColor: Colors.red,
                      ));
                    } else if (state is SignUpSuccess) {
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const HomeScreen()));
                    }
                  },
                  builder: (context, state) {
                    return InkWell(
                      onTap: () async {
                        log('SignUp');
                        BlocProvider.of<AuthCubit>(context).signUp(
                            email: _emailController.text,
                            password: _passwordController.text,
                            userName: _userNameController.text,
                            bio: _bioController.text,
                            profileImage: _profileImage);
                      },
                      child: CustomButton(
                          widget: state is SignUpLoading
                              ? const CircularProgressIndicator.adaptive()
                              : const Text("Sign up")),
                    );
                  },
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
        ),
      )),
    );
  }
}
