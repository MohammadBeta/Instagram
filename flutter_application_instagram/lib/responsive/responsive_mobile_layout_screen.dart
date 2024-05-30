import 'dart:developer';

import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    log('ResponsiveMobileLayout Widget Build');
    return const Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: []),
      ),
    );
  }
}
