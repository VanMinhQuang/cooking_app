import 'package:cached_network_image/cached_network_image.dart';
import 'package:cooking_project/core/styles/color.dart';
import 'package:cooking_project/core/styles/text_theme.dart';
import 'package:cooking_project/data/constant/constant_app.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isVisiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            _backgroundColor(),
            _body(),
            // Transparent Floating Back Button
            Positioned(
              top:
                  MediaQuery.of(context).padding.top + 10, // Safe area handling
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
          ],
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
    return // Login Card
        Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo
              SizedBox(
                  width: 80,
                  height: 80,
                  child: logoImage),

              SizedBox(height: 10),
              // Login Form
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Sign into your account"),
                      SizedBox(height: 20),
                      // Email TextField
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Phone",
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Password TextField
                      TextField(
                        obscureText: !_isVisiblePassword,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_isVisiblePassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isVisiblePassword = !_isVisiblePassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot your password?",
                          style: TextStyle(color: colorPrimary700),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text("Login",
                              style: TextThemeStyle.textSecondaryFontSizeBold(
                                  14,
                                  color: colorWhite)),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(child: Text("Or login using social media")),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          // Ensures the icons are centered
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              // Adds spacing between icons
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                // Optional padding
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[
                                      200], // Background color for the icon
                                ),
                                child: Icon(Icons.facebook,
                                    size: 32, color: Colors.blue),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              // Adds spacing between icons
                              child: Container(
                                height: 40,
                                width: 40,
                                padding: const EdgeInsets.all(8.0),
                                // Optional padding
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[
                                      200], // Background color for the icon
                                ),
                                child: googleIcon,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          "Don't have an account? Register Now",
                          style: TextStyle(color: colorPrimary800),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
