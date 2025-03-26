import 'package:cooking_project/core/styles/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomNavigationBar extends StatelessWidget {
  Function(int)? onTapChange;
  CustomNavigationBar({super.key, this.onTapChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40))
      ),
      child: GNav(
          rippleColor: colorPrimary800,
          hoverColor: colorPrimary700,
          tabBackgroundColor: Colors.green,
          tabBorderRadius: 40,
          gap: 16,
          onTabChange: (value)  {
            onTapChange!(value);
          },
          tabs: [
                GButton(icon: CupertinoIcons.house,text: 'Home',),
                GButton(icon: CupertinoIcons.search,text: 'Search',),
                GButton(icon: CupertinoIcons.profile_circled,text: 'Profile',),
          ]
      ),
    );
  }
}
