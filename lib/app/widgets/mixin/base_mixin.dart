import 'package:cooking_project/core/styles/color.dart';
import 'package:flutter/material.dart';

mixin BaseMixin<T extends StatefulWidget> on State<T> {
  bool _isDialogShowing = false;

  void showProgressDialog({String? message}) {
    if (_isDialogShowing) return;

    _isDialogShowing = true;
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing on tap outside
      builder: (context) {
        return Stack(
          children: [
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void hideProgressDialog() {
    if (_isDialogShowing) {
      _isDialogShowing = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Widget background(){
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
}