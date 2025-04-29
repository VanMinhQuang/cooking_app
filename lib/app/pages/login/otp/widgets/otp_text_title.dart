import 'package:cooking_project/core/styles/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpInstructions extends StatelessWidget {
  const OtpInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Please enter your OTP below",
              textAlign: TextAlign.center,
              style: TextThemeStyle.textSecondaryFontSizeBold(20.sp,
                  color: Colors.white),
            ),
          ),
        ),
        Center(
          child: Text(
            "Don't share this code with anyone.",
            style: TextThemeStyle.textSecondaryFontSizeBold(15.sp,
                color: Colors.white),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
