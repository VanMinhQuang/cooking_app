import 'package:cooking_project/core/styles/color.dart';
import 'package:cooking_project/core/styles/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpFields extends StatelessWidget {
  final Function(String) onSubmit;
  final Function(List<TextEditingController?>) onControllersReady;
  final bool clearText;

  const OtpFields({
    required this.onSubmit,
    required this.onControllersReady,
    required this.clearText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: 6,
      borderColor: const Color(0xFF512DA8),
      focusedBorderColor: colorPrimary800,
      clearText: clearText,
      showFieldAsBox: true,
      textStyle:
      TextThemeStyle.textSecondaryFontSizeBold(20.sp, color: Colors.white),
      onCodeChanged: (_) {},
      handleControllers: onControllersReady,
      onSubmit: onSubmit,
    );
  }
}
