import 'package:flutter/cupertino.dart';

class ScreenApp {
  ScreenApp._();
  static late double screenWidth;
  static late double screenHeight;
  static late double textScale;

  static void init(BuildContext context){
    var media = MediaQuery.of(context);
    screenWidth = media.size.width;
    screenHeight = media.size.height;
    textScale = MediaQuery.textScalerOf(context).textScaleFactor;
  }
}