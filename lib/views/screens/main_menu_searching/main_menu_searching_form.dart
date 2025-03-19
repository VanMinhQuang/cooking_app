import 'package:cooking_project/data/model/Food.dart';
import 'package:cooking_project/views/screens/meal/detail_meal/detail_meal_screen.dart';
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
  List<Food>? tempList;
  final _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    foodList = Food.foodList;
    tempList = <Food>[];
    tempList!.addAll(foodList!);
  }


  Future<void> _refresIndicator() async {
    setState(() {
      foodList = Food.foodList;
      tempList = <Food>[];
      tempList!.addAll(foodList!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresIndicator,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
                width: 2, color: Colors.white24, style: BorderStyle.solid),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                child: BoxFieldSearch(
                  controller: _searchController,
                  onClear: (text) {},
                  onFieldChange: (value) {

                  },
                  onSubmit: (text) {
                    setState(() {
                      if(text.isNotEmpty) {
                        tempList = foodList!.where((e) => e.foodName!.contains(text) || e.foodId!.contains(text)).toList();
                      } else {
                        tempList = foodList;
                      }
                    });
                  },
                  hintText: 'Search using food name or category',
                  icon: Icons.search,
                ),
              ),
              Expanded(
                // Ensures ListView takes available space
                child: ListView.builder(
                  itemCount: tempList?.length,
                  itemBuilder: (context, index) {
                    var item =  tempList?[index];
                    return Hero(
                      tag: item?.foodId ?? '',
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailMealScreen(food: item,),
                            )),
                        child: Card(
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
                                      item?.image ?? '',
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                          Icon(Icons.error),
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
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
                                        item?.foodName ?? '',
                                        style:
                                            TextStyle(fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        item?.category?.join(',') ?? '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black38),
                                      ),
                                      Text(item?.descr ?? ''),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
