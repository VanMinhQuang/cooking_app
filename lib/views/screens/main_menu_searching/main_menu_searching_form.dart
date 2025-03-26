import 'package:cached_network_image/cached_network_image.dart';
import 'package:cooking_project/data/model/Food.dart';
import 'package:cooking_project/data/model/meal_model.dart';
import 'package:cooking_project/views/screens/main_menu_searching/main_menu_searching_state.dart';
import 'package:cooking_project/views/screens/meal/detail_meal/detail_meal_screen.dart';
import 'package:cooking_project/views/widgets/box_field/box_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../data/constant/constant_app.dart';
import 'main_menu_searching_cubit.dart';

class MainMenuSearchingForm extends StatefulWidget {
  const MainMenuSearchingForm({super.key});

  @override
  State<MainMenuSearchingForm> createState() => _MainMenuSearchingFormState();
}

class _MainMenuSearchingFormState extends State<MainMenuSearchingForm> {
  List<Food>? foodList;
  List<Food>? tempList;
  List<Meal>? mealList;
  bool? isLoading = true;
  final _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    foodList = Food.foodList;
    tempList = <Food>[];
    tempList!.addAll(foodList!);
    context.read<MainMenuCubit>().loadListFood();
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
          child: BlocListener<MainMenuCubit,MainMenuSearchingState>(

            listener: ( context,  state) {
                if(state is MainMenuSearchingLoading){
                  isLoading = true;
                }
                else if (state is MainMenuSearchingLoaded){
                  isLoading = false;
                  mealList = state.foods;
                }
                else if (state is MainMenuSearchingError){
                  isLoading = false;
                }

            },
            child: Column(
              children: [
                _buildSeacrh(),
                _buildListMeal()

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeacrh(){
    return Container(
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
    );
  }

  Widget _buildListMeal(){
    return   Expanded(
      // Ensures ListView takes available space
      child: BlocBuilder<MainMenuCubit,MainMenuSearchingState>(
        buildWhen: (previous, current) {
          return current is! MainMenuSearchingError || current is! MainMenuSearchingLoading;
        },
        builder: ( context,  state) {
          return Skeletonizer(
            enabled: isLoading ?? true,
            child: ListView.builder(
              itemCount: mealList?.length,
              itemBuilder: (context, index) {
                var item =  mealList?[index];
                return Hero(
                  tag: item?.mealID ?? '',
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
                                  child: CachedNetworkImage(
                                    imageUrl: item?.image ?? '',
                                    alignment: Alignment.center,
                                    fit: BoxFit.scaleDown,
                                    placeholder: (context, url) => defaultImageEmpty,
                                    errorWidget: (context, url, error) => defaultImageEmpty,
                                  )
                              ),
                            ),
                            SizedBox(width: 10), // Space between image and text
            
                            // Text Section (Expanded to prevent overflow)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item?.mealName ?? '',
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    item?.method?.join(',') ?? '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black38),
                                  )
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
          );
        },

      ),
    );
  }


}
