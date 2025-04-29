import 'package:flutter/material.dart';

class IndicatorDots extends StatelessWidget {
  final int currentIndex;
  final int totalDots;

  const IndicatorDots({
    super.key,
    required this.currentIndex,
    this.totalDots = 2,
  });

  Widget _buildDot(bool isActive) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.orange : Colors.grey[300],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalDots,
            (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: _buildDot(index == currentIndex),
        ),
      ),
    );
  }
}