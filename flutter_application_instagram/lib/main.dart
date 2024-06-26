import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/firebase/auth_metohds.dart';
import 'package:flutter_application_instagram/features/auth/presentation/views/login_screen.dart';
import 'package:flutter_application_instagram/user_cubit/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_colors.dart';
import 'firebase_options.dart';
import 'responsive/responsive_layout_screen.dart';
import 'responsive/responsive_mobile_layout_screen.dart';
import 'responsive/responsive_web_layout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(BlocProvider<UserCubit>(
    child: const MainApp(),
    create: (context) => UserCubit(authMethods: AuthMethods()),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreen: ResponsiveMobileLayout(),
                  webScreen: ResponsiveWebLayout(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: primaryColor));
            }
            return const LoginScreen();
          },
        ));
  }
}
