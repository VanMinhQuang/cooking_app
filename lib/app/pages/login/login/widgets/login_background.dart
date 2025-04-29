import 'package:flutter/material.dart';
import 'package:cooking_project/core/styles/color.dart';

class LoginBackgroundWidget extends StatelessWidget {
  const LoginBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorPrimary800, colorPrimaryAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}