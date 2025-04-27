import 'package:cooking_project/core/styles/color.dart';
import 'package:cooking_project/core/styles/text_theme.dart';
import 'package:cooking_project/data/constant/constant_app.dart';
import 'package:cooking_project/routes.dart';
import 'package:cooking_project/views/screens/home/home_screen.dart';
import 'package:cooking_project/views/screens/login/login/login_cubit.dart';
import 'package:cooking_project/views/screens/login/login/login_state.dart';
import 'package:cooking_project/views/screens/login/otp/otp_screen.dart';
import 'package:cooking_project/views/widgets/mixin/base_mixin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with ProgressDialogMixin {
  final TextEditingController _phoneController = TextEditingController();
  bool _isPhoneEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if(state is LoginSuccess){
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false,
              );
            }else
            if(state is LoginLoading){
              showProgressDialog(message: '');
            }else
            if (state is VerifyPhoneSuccess) {
              Navigator.pushNamed(
                context,
                AppRoutes.otp,
                arguments: state.verificationId, // Pass verificationId
              );
            }
            else if(state is LoginFail){
              hideProgressDialog();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.error ?? '')),
              );
            }
          },
          child: Stack(
            children: [
              _backgroundColor(),
              _body(),
              // Transparent Floating Back Button
              Positioned(
                top: MediaQuery.of(context).padding.top +
                    10.sp, // Safe area handling
                left: 10.sp,
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
            ],
          ),
        ));
  }

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

  Widget _body() {
    return BlocBuilder<LoginCubit,LoginState>(builder: ( context,  state) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                SizedBox(width: 80.sp, height: 80.sp, child: logoImage),

                SizedBox(height: 10.sp),
                // Login Form
                _loginBody()
              ],
            ),
          ),
        ),
      );
    },

    );
  }

  Widget _loginBody() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.sp),
      ),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(20.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello Chief",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("Sign into your account"),
            SizedBox(height: 20.sp),
            // Email TextField
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone",
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isPhoneEmpty ? Colors.red : Colors.grey,
                  ),
                  //  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20.sp),
            // Login Button
            SizedBox(
              width: double.infinity,
              height: 50.sp,
              child: ElevatedButton(
                onPressed: () {
                  var phoneNumber = _phoneController.text;
                  if (phoneNumber.isNotEmpty) {
                    phoneNumber = _modifyPhoneNumber(phoneNumber);
                    _verifyPhoneNumber(phoneNumber);
                  } else {
                    setState(() {
                      _isPhoneEmpty = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Please enter a valid phone number')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Login",
                    style: TextThemeStyle.textSecondaryFontSizeBold(14,
                        color: colorWhite)),
              ),
            ),
            SizedBox(height: 10.sp),
            Center(child: Text("Or login using social media")),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                // Ensures the icons are centered
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    // Adds spacing between icons
                    child: InkWell(
                      onTap: () => context.read<LoginCubit>().loginFacebook(),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        // Optional padding
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors
                              .grey[200], // Background color for the icon
                        ),
                        child: Icon(Icons.facebook,
                            size: 32.sp, color: Colors.blue),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    // Adds spacing between icons
                    child: InkWell(
                      onTap: () => context.read<LoginCubit>().loginGoogle(),
                      child: Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(8.0),
                        // Optional padding
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors
                              .grey[200], // Background color for the icon
                        ),
                        child: googleIcon,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  String _modifyPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith('0')) {
      return phoneNumber =
          '+84${phoneNumber.substring(1)}';
    } else if (!phoneNumber.startsWith('+84')) {
      return phoneNumber =
          '+84$phoneNumber';
    }
    return phoneNumber;
  }

  void _verifyPhoneNumber(String phoneNumber) {
    context.read<LoginCubit>().loginPhone(phoneNumber: phoneNumber);
  }
}
