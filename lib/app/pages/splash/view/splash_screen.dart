import 'package:cooking_project/core/styles/color.dart';
import 'package:cooking_project/data/constant/constant_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [colorPrimary800, colorPrimaryAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Stack(
          children: <Widget>[
            Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOutBack,
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: SizedBox(
                      width: 120.sp,
                      height: 120.sp,
                      child: logoImage,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
