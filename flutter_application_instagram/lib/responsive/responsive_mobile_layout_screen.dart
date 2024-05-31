import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';
import 'package:flutter_application_instagram/core/constants/global_variables.dart';

class ResponsiveMobileLayout extends StatefulWidget {
  const ResponsiveMobileLayout({super.key});

  @override
  State<ResponsiveMobileLayout> createState() => _ResponsiveMobileLayoutState();
}

class _ResponsiveMobileLayoutState extends State<ResponsiveMobileLayout> {
  @override
  void initState() {
    super.initState();
  }

  final PageController _pageController = PageController();
  int _page = 0;
  void navigateTabItem(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    log('ResponsiveMobileLayout Widget Build');
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        onTap: (value) {
          navigateTabItem(value);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _page == 0 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _page == 1 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: _page == 2 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: _page == 3 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _page == 4 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
        ],
      ),
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            _page = value;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: bottomBarItems,
      ),
    );
  }
}
