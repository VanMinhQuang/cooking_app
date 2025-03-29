import 'package:cached_network_image/cached_network_image.dart';
import 'package:cooking_project/core/helper/format_number.dart';
import 'package:cooking_project/core/styles/color.dart';
import 'package:cooking_project/core/styles/icons.dart';
import 'package:cooking_project/core/styles/text_theme.dart';
import 'package:cooking_project/data/model/Food.dart';
import 'package:cooking_project/data/model/meal_model.dart';
import 'package:cooking_project/views/screens/main_menu_searching/main_menu_searching_state.dart';
import 'package:cooking_project/views/screens/meal/detail_meal/detail_meal_screen.dart';
import 'package:cooking_project/views/widgets/box_field/box_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    context.read<MainMenuCubit>().loadListFood();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      edgeOffset: 0,
      displacement: 50,
      strokeWidth: 5,
      onRefresh: _refresIndicator,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
                width: 2, color: Colors.white24, style: BorderStyle.solid),
          ),
          child: BlocListener<MainMenuCubit, MainMenuSearchingState>(
            listener: (context, state) {
              if (state is MainMenuSearchingLoading) {
                isLoading = true;
              } else if (state is MainMenuSearchingLoaded) {
                isLoading = false;
                mealList = state.foods;
              } else if (state is MainMenuSearchingError) {
                isLoading = false;
              }
            },
            child: Column(
              children: [_buildSeacrh(), _buildListMeal()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeacrh() {
    return Container(
      padding: EdgeInsets.all(4),
      child: BoxFieldSearch(
        controller: _searchController,
        onClear: (text) {},
        onFieldChange: (value) {},
        onSubmit: (text) {
          setState(() {
            if (text.isNotEmpty) {
              tempList = foodList!
                  .where((e) =>
                      e.foodName!.contains(text) || e.foodId!.contains(text))
                  .toList();
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

  Widget _buildListMeal() {
    return Expanded(
      // Ensures ListView takes available space
      child: BlocBuilder<MainMenuCubit, MainMenuSearchingState>(
        buildWhen: (previous, current) {
          return current is! MainMenuSearchingError ||
              current is! MainMenuSearchingLoading;
        },
        builder: (context, state) {
          return Skeletonizer(
            enabled: isLoading ?? true,
            child: ListView.builder(
              itemCount: mealList?.length,
              itemBuilder: (context, index) {
                var item = mealList?[index];
                return Card(
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailMealScreen(
                            food: item,
                          ),
                        )),
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
                                child: Hero(
                                  tag: item?.mealID ?? '',
                                  child: CachedNetworkImage(
                                    imageUrl: item?.image ?? '',
                                    alignment: Alignment.center,
                                    fit: BoxFit.scaleDown,
                                    placeholder: (context, url) =>
                                        defaultImageEmpty,
                                    errorWidget: (context, url, error) =>
                                        defaultImageEmpty,
                                  ),
                                )),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: item?.mealName ?? '',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors
                                                    .black, // Ensure text is visible
                                              ),
                                            ),
                                            WidgetSpan(
                                              child: (item?.isVegan ?? false)
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets
                                                              .only(left: 6),
                                                      // Add spacing
                                                      child: Container(
                                                        width: 17,
                                                        height: 17,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: colorPrimary,
                                                          // Background color
                                                          shape: BoxShape
                                                              .circle, // Makes it a circle
                                                        ),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.eco,
                                                            // Leaf icon
                                                            color:
                                                                Colors.white,
                                                            size: 13,
                                                          ),
                                                        ),
                                                      ))
                                                  : const SizedBox(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    _iconAndText(
                                      Icons.favorite_rounded,
                                      item?.totalLike, // Ensures no null values
                                      Colors.red,
                                      'LIKE'
                                    ),
                                    _iconAndText(
                                      Icons.timer,
                                      item?.totalTime, // Ensures no null values
                                      colorBlack,
                                      'TIME'
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  child: Wrap(
                                      spacing: 8,
                                      runSpacing: 4,
                                      children:
                                          (item?.method ?? []).map((method) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 8),
                                          decoration: BoxDecoration(
                                            color: colorPrimary800,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                          child: Text(
                                            method,
                                            // Display each method separately
                                            style: TextThemeStyle
                                                .textWhiteFontSizeBold11,
                                          ),
                                        );
                                      }).toList()),
                                )
                              ],
                            ),
                          ),
                        ],
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

  Widget _iconAndText(IconData icon, int? num, Color color,String type){
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.only(right: 1, left: 3),
          child: Text(
            type == 'LIKE' ? Formatter.formatTotalLike(num) : Formatter.formatTime(num),
            style: TextThemeStyle
                .textSecondaryFontSizeBold(15,color: type == 'LIKE' ? colorPink : colorSecondary),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 2,),
          child: Icon(
            icon,
            size: 18,
            color: color,
          ),
        )
      ],
    );
  }
}
