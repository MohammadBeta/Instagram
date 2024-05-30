import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/providors/user_providor.dart';
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

  addData() async {
    await Provider.of<UserProvidor>(context, listen: false).getUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: addData(),
        builder: (context, a) {
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > webScreenSize) {
                return widget.webScreen;
              }
              return widget.mobileScreen;
            },
          );
        });
  }
}
