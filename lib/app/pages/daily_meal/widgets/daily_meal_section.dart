import 'package:flutter/material.dart';
import '../../../../core/enum/MealType.dart';

class MealSection extends StatelessWidget {
  final MealType type;
  final List<Widget> meals;
  final VoidCallback? onAddMeal;

  const MealSection({
    super.key,
    required this.type,
    this.meals = const [],
    this.onAddMeal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          type.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...meals,
        if (onAddMeal != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: onAddMeal,
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 20,
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.add_circle, color: Colors.green),
                      SizedBox(width: 10),
                      Text("Thêm món ăn"),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
