import 'package:cooking_project/core/styles/color.dart';
import 'package:flutter/material.dart';

class TextThemeStyle{

  static const fontWeight = FontWeight.w700;

  static TextStyle textBlackFontSizeBold13 = TextStyle(color: colorBlack, fontSize: 13, fontWeight: fontWeight);

  static TextStyle textBlackFontSizeBold11 = TextStyle(color: colorBlack, fontSize: 11, fontWeight: fontWeight);


  static TextStyle textWhiteFontSizeBold11 = TextStyle(color: colorWhite, fontSize: 11, fontWeight: fontWeight);


  static TextStyle textSecondaryFontSizeBold(double fontSize, {Color? color}){
    return TextStyle(color: color ?? colorSecondary,  fontWeight: fontWeight, fontSize: fontSize);
  }
}