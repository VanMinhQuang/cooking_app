import 'package:cooking_project/core/styles/color.dart';
import 'package:flutter/material.dart';

class TextThemeStyle{

  static const fontWeight = FontWeight.w700;
  static String fontFamily = 'Arial';

  static TextStyle textBlackFontSizeBold13 = TextStyle(color: colorBlack, fontSize: 13, fontWeight: fontWeight, fontFamily: fontFamily);
  static TextStyle textBlackFontSizeBold16 = TextStyle(color: colorBlack, fontSize: 16, fontWeight: fontWeight, fontFamily: fontFamily);
  static TextStyle textBlackFontSizeBold11 = TextStyle(color: colorBlack, fontSize: 11, fontWeight: fontWeight, fontFamily: fontFamily);


  static TextStyle textWhiteFontSizeBold11 = TextStyle(color: colorWhite, fontSize: 11, fontWeight: fontWeight, fontFamily: fontFamily);


  static TextStyle textSecondaryFontSizeBold(double fontSize, {Color? color}){
    return TextStyle(color: color ?? colorSecondary,  fontWeight: fontWeight, fontSize: fontSize, fontFamily: fontFamily);
  }


  static TextStyle textBlackNoWeightCustomSize(double fontSize){
    return TextStyle(color: colorLowBlack,   fontSize: fontSize, fontFamily: fontFamily);
  }
}