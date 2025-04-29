import 'package:cooking_project/core/styles/color.dart';
import 'package:cooking_project/core/styles/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData icon;

  const MealTile({
    super.key,
    required this.title,
    required this.onTap,
    this.icon = Icons.add_circle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                Icon(icon, size: 18.sp, color: colorPrimary),
                SizedBox(width: 20),
                Text(
                  title,
                  maxLines: 2,
                  style: TextThemeStyle.textBlackFontSizeBold16,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
