import 'package:flutter/material.dart';
import 'package:cooking_project/core/styles/color.dart';

class SettingOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? color;
  final bool isLogout;

  const SettingOptionTile({
    super.key,
    required this.icon,
    required this.title,
    this.color,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? colorWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          // Add functionality here
        },
        child: ListTile(
          leading: Icon(icon, color: Colors.black54),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: Icon(
            isLogout ? Icons.logout : Icons.arrow_forward_ios,
            size: 16,
          ),
        ),
      ),
    );
  }
}
