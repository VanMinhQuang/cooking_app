import 'package:flutter/cupertino.dart';

import 'main_menu_searching_form.dart';

class MainMenuSearchingScreen extends StatefulWidget {
  const MainMenuSearchingScreen({super.key});

  @override
  State<MainMenuSearchingScreen> createState() => _MainMenuSearchingScreenState();
}

class _MainMenuSearchingScreenState extends State<MainMenuSearchingScreen> {
  @override
  Widget build(BuildContext context) {
    return  MainMenuSearchingForm();
  }
}
