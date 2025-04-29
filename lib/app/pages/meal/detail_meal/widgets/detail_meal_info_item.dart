import 'package:cooking_project/core/helper/format_number.dart';
import 'package:cooking_project/core/styles/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoItem extends StatelessWidget {
  final IconData icon;
  final int num;
  final Color textColor;
  final String type;
  final Color boxColor;

  const InfoItem({
    Key? key,
    required this.icon,
    required this.num,
    required this.textColor,
    required this.type,
    required this.boxColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.sp),
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 4.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.sp),
        color: boxColor,
      ),
      child: Wrap(
        children: [
          Container(
            padding: EdgeInsets.only(top: 2.sp),
            child: Icon(
              icon,
              size: 15.sp,
              color: textColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1.sp, left: 3.sp),
            child: Text(
              type == 'TIME' ? Formatter.formatTime(num) : num.toString(),
              style: TextThemeStyle.textSecondaryFontSizeBold(
                12.sp,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}