import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'responsive/responsive_layout_screen.dart';
import 'responsive/responsive_mobile_layout_screen.dart';
import 'responsive/responsive_web_layout_screen.dart';
import 'utilis/colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        debugShowCheckedModeBanner: false,
        home: const ResponsiveLayout(
          mobileScreen: ResponsiveMobileLayout(),
          webScreen: ResponsiveWebLayout(),
        ));
  }
}
