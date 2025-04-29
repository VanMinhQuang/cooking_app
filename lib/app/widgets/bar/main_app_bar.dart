import 'package:cooking_project/core/styles/color.dart';
import 'package:flutter/material.dart';

class CustomMealAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? isHaveSearchField;
  const CustomMealAppBar({
    super.key,
    this.isHaveSearchField
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: Container(
        color: colorMintGreen, // mint green
        height: preferredSize.height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left Icon
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border),
                color: Colors.white,
              ),

              Expanded(
                child: Center(
                  child: Text(
                    'Meal For U',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),


              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.person_outline),
                    color: Colors.white,
                  ),
                  if (isHaveSearchField ?? false)
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                      color: Colors.white,
                    ),
                  // Person Outline Icon

                ],
              ),
            ],
          )
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight(80);
}