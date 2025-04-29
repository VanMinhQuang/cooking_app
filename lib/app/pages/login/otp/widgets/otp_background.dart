import 'package:cooking_project/core/styles/color.dart';
import 'package:flutter/material.dart';

class OtpBackground extends StatelessWidget {
  const OtpBackground({super.key});

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
