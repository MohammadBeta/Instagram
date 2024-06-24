import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/user_cubit/user_cubit.dart';
import 'package:provider/provider.dart';

import '../core/constants/platforms_diminssions.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreen;
  final Widget mobileScreen;
  const ResponsiveLayout(
      {super.key, required this.webScreen, required this.mobileScreen});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> initUser() async {
    await context.read<UserCubit>().refreshUser();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > webScreenSize) {
                    return widget.webScreen;
                  }
                  return widget.mobileScreen;
                },
              );
            } else {
              return const Center(
                child: Text("Failed to load data"),
              );
            }
          } else {
            return const Center(
              child: Text("No Data"),
            );
          }
        });
  }
}
