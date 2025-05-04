import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/constant/constant_app.dart';
import '../cubit/login_cubit.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () => context.read<LoginCubit>().loginFacebook(),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              child: Icon(Icons.facebook, size: 32.sp, color: Colors.blue),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          // Adds spacing between icons
          child: GestureDetector(
            onTap: () => context.read<LoginCubit>().loginGoogle(),
            child: Container(
              height: 40.sp,
              width: 40.sp,
              padding: const EdgeInsets.all(8.0),
              // Optional padding
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200], // Background color for the icon
              ),
              child: googleIcon,
            ),
          ),
        ),
      ],
    );
  }
}
