
import 'package:cooking_project/core/singleton/injection_container.dart';
import 'package:cooking_project/data/repository/login_repository.dart';
import 'package:cooking_project/domain/use_cases/auth_use_case/verify_otp_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/repositories/auth_repo/login_auth_repo.dart';

import '../cubit/otp_cubit.dart';
import 'otp_form.dart';

class OtpScreen extends StatelessWidget {
  String? verificationID;
  OtpScreen( {super.key, required this.verificationID});

  @override
  Widget build(BuildContext context) {
    final loginRepository = sl<LoginRepository>();
    return BlocProvider(create: (BuildContext context) {

      return OtpCubit(verifyOTPUseCase: VerifyOTPUseCase(loginRepository:loginRepository  ));
    },
    child: OtpForm(verificationID: verificationID,));
  }
}
