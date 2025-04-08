import 'package:flutter/material.dart';

class CustomMealAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomMealAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: Container(
        color: Color(0xFFAEDDC5), // mint green
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

              // Title
              Text(
                'Meal For U',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.white,
                ),
              ),

              // Right Icon
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.person_outline),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}