

import 'package:cooking_project/app/pages/home/view/home_screen.dart';
import 'package:cooking_project/app/pages/login/login/view/login_screen.dart';
import 'package:cooking_project/app/pages/login/otp/view/otp_screen.dart';
import 'package:cooking_project/app/pages/main_menu_searching/view/main_menu_searching_screen.dart';
import 'package:cooking_project/app/pages/meal/detail_meal/view/detail_meal_screen.dart';
import 'package:cooking_project/app/pages/meal/meal_step/view/meal_step_screen.dart';
import 'package:cooking_project/app/pages/setting/view/setting_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/';
  static const String mainMenuSearching = '/main_menu_searching';
  static const String setting = '/setting';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String step = '/step';
  static const String detail = '/detail';

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
      case step:
        return MaterialPageRoute(builder: (_) => const MealStepScreen(),);
      case detail:
        final args = settings.arguments as Map<String, dynamic>?;
        final food = args?['food'];
        final heroTag = args?['heroTag'];
        return MaterialPageRoute(builder: (_) =>  DetailMealScreen(food: food,heroTag: heroTag,));
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
