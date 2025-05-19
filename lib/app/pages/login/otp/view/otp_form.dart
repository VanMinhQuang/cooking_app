import 'package:cooking_project/app/pages/home/view/home_screen.dart';
import 'package:cooking_project/app/pages/login/otp/cubit/otp_cubit.dart';
import 'package:cooking_project/app/pages/login/otp/cubit/otp_state.dart';
import 'package:cooking_project/app/widgets/mixin/base_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/otp_widgets.dart';

class OtpForm extends StatefulWidget {
  final String? verificationID;

  const OtpForm({required this.verificationID, super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> with BaseMixin {
  late List<TextEditingController?> controls;
  bool clearText = false;

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
            return Stack(
              children: [
                const OtpBackground(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OtpFields(
                          onSubmit: (code) {
                            context.read<OtpCubit>().verifyOtp(
                              otp: code,
                              verificationId: widget.verificationID ?? '',
                            );
                          },
                          onControllersReady: (c) => controls = c,
                          clearText: clearText,
                        ),
                        const SizedBox(height: 20),
                        const OtpInstructions(),
                      ],
                    ),
                  ),
                ),
                const OtpBackButton(),
              ],
            );
          },
        ),
      ),
    );
  }
}
