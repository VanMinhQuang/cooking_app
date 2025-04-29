import 'package:cooking_project/app/pages/login/login/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cooking_project/core/styles/text_theme.dart';

import 'login_button.dart';

class LoginCard extends StatelessWidget {
  final TextEditingController phoneController;
  final bool isPhoneEmpty;
  final VoidCallback onLoginPressed;

  const LoginCard({
    Key? key,
    required this.phoneController,
    required this.isPhoneEmpty,
    required this.onLoginPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            // Phone TextField
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone",
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isPhoneEmpty ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.sp),
            // Login Button
            LoginButton(onPressed: onLoginPressed),
            SizedBox(height: 10.sp),
            Center(child: Text("Or login using social media")),
            Center(child: SocialLoginButtons()),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
