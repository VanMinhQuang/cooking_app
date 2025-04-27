import 'package:cooking_project/core/styles/color.dart';
import 'package:cooking_project/core/styles/text_theme.dart';
import 'package:cooking_project/routes.dart';
import 'package:cooking_project/views/screens/home/home_screen.dart';
import 'package:cooking_project/views/screens/login/otp/otp_cubit.dart';
import 'package:cooking_project/views/screens/login/otp/otp_state.dart';
import 'package:cooking_project/views/screens/setting/setting_screen.dart';
import 'package:cooking_project/views/widgets/mixin/base_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpForm extends StatefulWidget {
  String? verificationID;

  OtpForm({required this.verificationID, super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> with ProgressDialogMixin {
  late List<TextStyle?> otpTextStyles;
  late List<TextEditingController?> controls;
  bool clearText = false;

  Widget _backgroundColor() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state is OtpLoading) {
            showProgressDialog(message: '');
          } else if (state is OtpSucess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
            );
          } else if (state is OtpFail) {
            hideProgressDialog();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error ?? '')));
          }
        },
        child: BlocBuilder<OtpCubit, OtpState>(
          builder: (context, state) {
            return Stack(children: [
              _backgroundColor(),
              Center(
                // This centers the entire body
                child: Container(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  // Optional: add right padding too
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // This centers the content in the column
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OtpTextField(
                        numberOfFields: 6,
                        borderColor: Color(0xFF512DA8),
                        focusedBorderColor: colorPrimary800,
                        clearText: clearText,
                        showFieldAsBox: true,
                        textStyle: TextThemeStyle.textSecondaryFontSizeBold(20.sp,
                            color: Colors.white),
                        onCodeChanged: (String value) {},
                        handleControllers: (controllers) {
                          controls = controllers;
                        },
                        onSubmit: (String verificationCode) {
                          print('otp');
                          context.read<OtpCubit>().verifyOtp(
                              otp: verificationCode,
                              verificationId: widget.verificationID ?? '');
                        }, // end onSubmit
                      ),
                      const SizedBox(height: 20),
                      // Optional: Add spacing between OTP field and text
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
                      // Optional: Add space at the bottom
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top +
                    10, // Safe area handling
                left: 10,
                child: Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
