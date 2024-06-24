import 'package:flutter_application_instagram/features/auth/presentation/views/login_screen.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> routes = [
  GoRoute(
    path: '/',
    builder: (context, state) {
      return const LoginScreen();
    },
  )
];
