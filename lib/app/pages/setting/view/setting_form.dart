import 'package:flutter/material.dart';
import 'package:cooking_project/core/styles/color.dart';

import '../widgets/setting_widgets.dart';


class SettingForm extends StatelessWidget {
  const SettingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingUserCard(),
            const SizedBox(height: 16),
            const Text(
              'Cài đặt',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const SettingOptionTile(
              icon: Icons.text_format,
              title: "Đánh giá app",
            ),
            const SettingOptionTile(
              icon: Icons.language,
              title: "Ngôn ngữ",
            ),
            const SettingOptionTile(
              icon: Icons.account_circle,
              title: "Đăng xuất",
              color: Color(0xFFFFCDD2), // colorRed.shade100
              isLogout: true,
            ),
          ],
        ),
      ),
    );
  }
}
