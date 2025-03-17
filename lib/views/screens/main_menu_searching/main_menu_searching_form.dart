import 'package:cooking_project/data/model/Food.dart';
import 'package:cooking_project/views/widgets/box_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainMenuSearchingForm extends StatefulWidget {
  const MainMenuSearchingForm({super.key});

  @override
  State<MainMenuSearchingForm> createState() => _MainMenuSearchingFormState();
}

class _MainMenuSearchingFormState extends State<MainMenuSearchingForm> {
  List<Food>? foodList;
  final _searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    foodList = Food.foodList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
              width: 2, color: Colors.white24, style: BorderStyle.solid),
        ),
        child: Column(
          children: [
            BoxFieldSearch(
              controller: _searchController,
              onClear: (text) {

              },
              onFieldChange: (value) {

              },
              hintText: 'Search using food name or category',
              icon: Icons.search,

            ),
            Expanded(
              // Ensures ListView takes available space
              child: ListView.builder(
                itemCount: foodList?.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image (fixed size to prevent layout issues)
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              // Set the border radius
                              child: Image.network(
                                foodList?[index].image ?? '',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.error),
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 10), // Space between image and text

                          // Text Section (Expanded to prevent overflow)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  foodList?[index].foodName ?? '',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  foodList?[index].category?.join(',') ?? '',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black38),
                                ),
                                Text(foodList?[index].descr ?? ''),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
