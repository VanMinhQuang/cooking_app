import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAlertDialog {
  static void showCustomDialog(
      {required BuildContext context,
      required DialogType type,
      required String title,
      required String content,
      required String btnOkText,
      required String btnCancelText,
      required Function()? onYesCb,
      required Function()? onCancelCb}) {
    Future.delayed(Duration(milliseconds: 100), () {
      AwesomeDialog(
        context: context,
        dialogType: type,
        borderSide: const BorderSide(
          color: Colors.green,
          width: 2,
        ),
        width: 280.sp,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: false,
        headerAnimationLoop: false,
        animType: AnimType.scale,
        title: title,
        btnOkText: btnOkText,
        btnCancelText: btnCancelText,
        desc: content,
        showCloseIcon: true,
        btnCancelOnPress: onCancelCb,
        btnOkOnPress: onYesCb,
      ).show();
    });

  }

  static void showErrorAlert(
      {required BuildContext context, required String content})  {
    Future.delayed(Duration(milliseconds: 100),() {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        borderSide: const BorderSide(
          color: Colors.green,
          width: 2,
        ),
        width: 280.sp,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: false,
        headerAnimationLoop: false,
        animType: AnimType.scale,
        title: 'Lỗi',
        desc: content,
        showCloseIcon: true,
      ).show();
    },);

  }


  static void preloadDialog(BuildContext context) {

    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      title: '',
      desc: '',
      btnOkOnPress: () {},
    );
  }
}
