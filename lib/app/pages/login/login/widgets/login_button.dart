import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cooking_project/core/styles/color.dart';
import 'package:cooking_project/core/styles/text_theme.dart';

class LoginButton extends StatelessWidget {
  final Function() onPressed;

  const LoginButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.sp,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text("Login", style: TextThemeStyle.textSecondaryFontSizeBold(14, color: colorWhite)),
      ),
    );
  }
}
