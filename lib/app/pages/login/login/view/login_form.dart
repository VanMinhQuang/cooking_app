import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../data/constant/constant_app.dart';
import '../../../../widgets/mixin/base_mixin.dart';
import '../widgets/login_background.dart';
import '../widgets/login_card.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import '../../../home/view/home_screen.dart';
import 'package:cooking_project/app/routes.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with BaseMixin {
  final TextEditingController _phoneController = TextEditingController();
  bool _isPhoneEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomeScreen(key: UniqueKey(),)),
                    (route) => false,
              );
            } else if (state is LoginLoading) {
              showProgressDialog(message: '');
            } else if (state is VerifyPhoneSuccess) {
              Navigator.pushNamed(
                context,
                AppRoutes.otp,
                arguments: state.verificationId,
              );
            } else if (state is LoginFail) {
              hideProgressDialog();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error ?? '')),
              );
            }
          },
          child: Stack(
            children: [
              const LoginBackgroundWidget(),
              _body(),
              // Transparent Floating Back Button
              Positioned(
                top: MediaQuery.of(context).padding.top + 10.sp,
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

  Widget _body() {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 80.sp, height: 80.sp, child: logoImage),
                  SizedBox(height: 10.sp),
                  LoginCard(
                    phoneController: _phoneController,
                    isPhoneEmpty: _isPhoneEmpty,
                    onLoginPressed: () {
                      var phoneNumber = _phoneController.text;
                      if (phoneNumber.isNotEmpty) {
                        phoneNumber = _modifyPhoneNumber(phoneNumber);
                        _verifyPhoneNumber(phoneNumber);
                      } else {
                        setState(() {
                          _isPhoneEmpty = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please enter a valid phone number')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _modifyPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith('0')) {
      return '+84${phoneNumber.substring(1)}';
    } else if (!phoneNumber.startsWith('+84')) {
      return '+84$phoneNumber';
    }
    return phoneNumber;
  }

  void _verifyPhoneNumber(String phoneNumber) {
    context.read<LoginCubit>().loginPhone(phoneNumber: phoneNumber);
  }
}
