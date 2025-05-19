import 'package:cooking_project/data/constant/constant_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class CustomAlertDialog {
  static void showBottomSheetPositiveDialog(
      {required BuildContext context,
      required String title,
      required String content,
      required String btnOkText,
      required String btnCancelText,
      required Function onYesCb}) {
    Dialogs.bottomMaterialDialog(
      msg: content,
      title: title,
      color: Colors.white,
      context: context,
      actionsBuilder: (context) {
        return  [
          IconsOutlineButton(
            onPressed: () => Navigator.of(context).pop(),
            text: btnCancelText,
            iconData: Icons.cancel_outlined,
            textStyle: TextStyle(color: Colors.grey),
            iconColor: Colors.grey,
          ),
          IconsButton(
            onPressed: onYesCb,
            text: btnOkText,
            iconData: Icons.done,
            color: Colors.green,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ];
      },
    );
  }

  static void showErrorAlert(
      {required BuildContext context, required String content}) {
    Dialogs.materialDialog(
      context: context,
      msg: content,
      customView: Column(
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: errorIcon,
          ),
          SizedBox(height: 16),
          Text(
            'Error Occurred',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Something went wrong. Please try again.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      dialogShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
