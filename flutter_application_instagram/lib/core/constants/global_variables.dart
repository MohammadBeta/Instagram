import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/screens/add_post_screen.dart';
import 'package:flutter_application_instagram/screens/home_screen.dart';
import 'package:flutter_application_instagram/screens/search_user_screen.dart';

List<Widget> bottomBarItems = [
  const HomeScreen(),
  const Center(child: SearchScreen()),
  const Center(child: AddPostScreenState()),
  const Center(child: Text("Four")),
  const Center(child: Text("Five"))
];
