import 'package:flutter/material.dart';

class MaterialText extends StatelessWidget {
  final String text;

  const MaterialText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(text),
    );
  }
}