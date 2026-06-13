import 'package:control_room/control_room.dart';
import 'package:flutter/material.dart';

import 'controllers/auth_controller.dart';
import 'controllers/case_controller.dart';
import 'controllers/dashboard_controller.dart';
import 'controllers/user_controller.dart';
import 'injection.dart';
import 'screens/dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  final authService = getIt<AuthService>();
  final isLoggedIn = await authService.loadSession();

  runApp(
    ControlRoom(
      controllers: {
        AuthController: () => AuthController(),
        DashboardController: () => DashboardController(),
        UserController: () => UserController(),
        CaseController: () => CaseController(),
      },
      child: LitigationAdminApp(isLoggedIn: isLoggedIn),
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class LitigationAdminApp extends StatelessWidget {
  final bool isLoggedIn;

  const LitigationAdminApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Litigation Admin',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: isLoggedIn ? const DashboardScreen() : const LoginScreen(),
    );
  }
}
