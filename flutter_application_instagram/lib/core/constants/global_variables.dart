import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/features/add_post/presentation/views/add_post_screen.dart';
import 'package:flutter_application_instagram/features/home/pesentation/views/home_screen.dart';
import 'package:flutter_application_instagram/features/profile/presentation/views/profile_screen.dart';
import 'package:flutter_application_instagram/features/search/presentaion/views/search_user_screen.dart';

List<Widget> bottomBarItems = [
  const HomeScreen(),
  const Center(child: SearchScreen()),
  const Center(child: AddPostScreenState()),
  const Center(child: Text("Four")),
  Center(child: ProfileScreen(userUid: FirebaseAuth.instance.currentUser!.uid))
];
