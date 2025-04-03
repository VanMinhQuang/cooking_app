import 'package:cooking_project/data/repository/login_repository.dart';
import 'package:cooking_project/views/screens/login/otp/otp_cubit.dart';
import 'package:cooking_project/views/screens/login/otp/otp_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpScreen extends StatelessWidget {
  String? verificationID;
  OtpScreen( {super.key, required this.verificationID});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) {

      return OtpCubit(loginRepository: LoginRepository());
    },
    child: OtpForm(verificationID: verificationID,));
  }
}
