import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cooking_project/app/pages/meal/detail_meal/view/detail_meal_screen.dart';
import 'package:cooking_project/core/styles/color.dart';
import 'package:cooking_project/data/constant/constant_app.dart';
import 'package:cooking_project/domain/entities/meal_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealCarouselWidget extends StatefulWidget {
  final List<Meal>? mealList;
  final String type;

  const MealCarouselWidget(
      {required this.mealList, required this.type, super.key});

  @override
  State<MealCarouselWidget> createState() => _MealCarouselWidgetState();
}

class _MealCarouselWidgetState extends State<MealCarouselWidget> {
  int _currentPage = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return  _buildGridMeal(widget.mealList!, widget.type);
  }

  Widget _buildGridMeal(List<Meal> mealList, String type) {
    int maxDots = 10; // Chấm tối đa hiện trên an hình
    int totalDots = mealList.length;
    int startIndex = (_currentPage ~/ maxDots) * maxDots; // dot sẽ  sáng
    int visibleDots =
        (startIndex + maxDots > totalDots) ? totalDots - startIndex : maxDots;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            padding: EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 220,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      enableInfiniteScroll: widget.mealList!.length > 1,
                      enlargeCenterPage: true,

                      autoPlayInterval: const Duration(seconds: 4),
                      autoPlay: widget.mealList!.length == 1 ? false : true,
                      initialPage: 0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentPage = index;
                          startIndex = (_currentPage ~/ maxDots) * maxDots; // dot sẽ  sáng
                          visibleDots =
                          (startIndex + maxDots > totalDots) ? totalDots - startIndex : maxDots;
                        });
                      },
                    ),
                    carouselController: _carouselController,
                    items: List.generate(
                      mealList.length,
                      (index) {
                        return _buildItemCarousel(mealList[index], type);
                      },
                    ),
                  ),
                ),
              ],
            )),
        widget.mealList!.length > 1
            ? Positioned(
                bottom: 220 * 0.002,
                child:
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(visibleDots, (index) {
                    bool isSelected =  _currentPage % maxDots == index;
                    return   AnimatedContainer(
                        width: isSelected ? 50 : 17,
                        height: 10.sp,
                        margin: EdgeInsets.symmetric(horizontal: isSelected ? 6 : 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: isSelected ? colorPrimary : Colors.grey[400],
                        ),

                        duration: const Duration(milliseconds: 300));
                  },)
                )
              )
            : const SizedBox()
      ],
    );
  }

  Widget _buildItemCarousel(Meal vegan, String type) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailMealScreen(
              food: vegan,
              heroTag: '${vegan.mealID}$type',
            ),
          )),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Stack(
              children: [
                Hero(
                  tag: '${vegan.mealID}$type',
                  child: CachedNetworkImage(
                    imageUrl: vegan.image ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => defaultImageEmpty,
                    errorWidget: (context, url, error) => defaultImageEmpty,
                    height: 220.sp,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Card(
                      color: Colors.transparent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: (vegan.isVegan ?? false)
                          ? Container(
                              width: 30.sp,
                              height: 30.sp,
                              decoration: BoxDecoration(
                                color: colorPrimary,
                                // Background color
                                shape: BoxShape.circle, // Makes it a circle
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.eco,
                                  // Leaf icon
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ),
                            )
                          : const SizedBox()),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Constrained name that won't overflow
                  Expanded(
                    child: Text(
                      vegan.mealName ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(width: 8),
                  // Like icon and count
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.favorite, color: Colors.red, size: 16.sp),
                      SizedBox(width: 4),
                      Text(
                        '${vegan.totalLike}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
