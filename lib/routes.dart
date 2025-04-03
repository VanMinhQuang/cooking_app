import 'package:cooking_project/views/screens/login/login/login_screen.dart';
import 'package:cooking_project/views/screens/main_menu_searching/main_menu_searching_screen.dart';
import 'package:flutter/material.dart';
import 'package:cooking_project/views/screens/home/home_screen.dart';
import 'package:cooking_project/views/screens/setting/setting_screen.dart';
import 'package:cooking_project/views/screens/login/otp/otp_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String screen1 = '/screen1';
  static const String mainMenuSearching = '/main_menu_searching';
  static const String setting = '/setting';
  static const String login = '/login';
  static const String otp = '/otp';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case mainMenuSearching:
        return MaterialPageRoute(builder: (_) => const MainMenuSearchingScreen());
      case setting:
        return MaterialPageRoute(builder: (_) => const SettingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case otp:
        final args = settings.arguments as String?; // Pass verificationId
        return MaterialPageRoute(builder: (_) => OtpScreen(verificationID: args ?? ''));

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
