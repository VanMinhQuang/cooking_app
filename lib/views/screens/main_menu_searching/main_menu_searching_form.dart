
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cooking_project/core/helper/format_number.dart';
import 'package:cooking_project/core/styles/color.dart';
import 'package:cooking_project/core/styles/text_theme.dart';
import 'package:cooking_project/data/model/meal_model.dart';
import 'package:cooking_project/views/screens/main_menu_searching/main_menu_searching_state.dart';
import 'package:cooking_project/views/screens/main_menu_searching/widget/meal_card.dart';
import 'package:cooking_project/views/screens/meal/detail_meal/detail_meal_screen.dart';
import 'package:cooking_project/views/widgets/bar/main_app_bar.dart';
import 'package:cooking_project/views/widgets/box_field/box_field_widget.dart';
import 'package:cooking_project/views/widgets/carousel/meal_carousel/animated_meal_carousel.dart';
import 'package:cooking_project/views/widgets/carousel/meal_carousel/meal_carousel.dart';
import 'package:cooking_project/views/widgets/stuffs/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  MainMenuMeal? mealList;
  bool? isLoading = true;
  final _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<MainMenuCubit>().loadListFood();
    });
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
        appBar: CustomMealAppBar(isHaveSearchField: true,),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              border: Border.all(
                  width: 2.sp,
                  color: Colors.white24,
                  style: BorderStyle.solid),
            ),
            child: BlocListener<MainMenuCubit, MainMenuSearchingState>(
              listener: (context, state) {
                if (state is MainMenuSearchingLoading) {
                  isLoading = true;
                } else if (state is MainMenuSearchingError) {
                  isLoading = false;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                } else if (state is MainMenuSearchingLoaded) {
                  isLoading = false;
                  mealList = state.foods;
                }
              },
              child: BlocBuilder<MainMenuCubit, MainMenuSearchingState>(
                buildWhen: (previous, current) =>
                current is MainMenuSearchingLoaded,
                builder: (context, state) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       buildSectionTitle('Món ăn yêu thích nhất',icon: Icons.favorite, bgColor: Colors.red),
                       Skeletonizer(enabled: isLoading ?? false, child: MealCarouselWidget(mealList: mealList?.tookMostTimeMeals ?? [], type: 'FAVORITE',)),
                       Components.separateLine(),
                       buildSectionTitle('Món ăn dành cho người thực vật', icon: Icons.eco, bgColor: Colors.green),
                       Skeletonizer(enabled: isLoading ?? false, child: MealCarouselWidget(mealList: mealList?.tookMostTimeMeals ?? [], type: 'FAVORITE',)),
                       Components.separateLine(),
                       buildSectionTitle('Danh muc',bgColor: Colors.grey, paddingBottom: 3),
                    //  // _buildSeacrh(),
                       _buildListMeal()
                    ]),
              )
            ),
          ),
        ),
      ),
    );
  }



  Widget buildSectionTitle(String title, {IconData? icon, required Color bgColor, double? paddingBottom }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: paddingBottom ?? 12),
      elevation: 4,
      child: Container(

        padding: EdgeInsets.symmetric(horizontal: 12, vertical:  6),
        decoration: BoxDecoration(
          color:  bgColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            icon == null ?  const SizedBox() :Icon(icon, color: bgColor, size: 20),
            SizedBox(width: 8.sp),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
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
        onSubmit: (text) {},
        hintText: 'Search using food name or category',
        icon: Icons.search,
      ),
    );
  }

  Widget _buildListMeal() {
    final list = mealList?.listMeals ?? [];
    return  SizedBox(
            height: 440,
            child: AnimatedCardsCarousel(

              onFetchMore: fetchMore,
              cardsList: List.generate(
                list.length,
                    (index) {
                      var meal = mealList?.listMeals?[index];
                      return CategoryCard(imageUrl: meal?.image ?? '', title: meal?.mealName ?? '');
                    },
              ),
            ),
          );
  }

  void fetchMore(){
      print('Fetch More');
  }

  Widget _buildGridItem(Meal item) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailMealScreen(
              food: item,
              heroTag: '${item.mealID ?? ''}MealGrid',
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: '${item.mealID ?? ''}MealGrid',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: item.image ?? '',
                      width: double.infinity,
                      height: 100.sp,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => defaultImageEmpty,
                      errorWidget: (context, url, error) => defaultImageEmpty,
                    ),
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
                      child: (item.isVegan ?? false)
                          ? Container(
                              width: 25.sp,
                              height: 25.sp,
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
                                  size: 15.sp,
                                ),
                              ),
                            )
                          : const SizedBox()),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8.sp, vertical: 3.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(20.sp),
                      ),
                      child: Text(
                        item.mealName ?? '',
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,

                        maxLines: 1,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  // Let icon take only needed space
                  _iconAndText(
                    Icons.favorite_rounded,
                    item.totalLike,
                    Colors.red,
                    'LIKE',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _iconAndText(IconData icon, int? num, Color color, String type,
      {Color? textColor}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 4.sp),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.sp), color: colorWhite),
      child: Wrap(
        children: [
          Container(
            padding: EdgeInsets.only(right: 1, left: 3),
            child: Text(
              type == 'LIKE'
                  ? Formatter.formatTotalLike(num)
                  : Formatter.formatTime(num),
              style: TextThemeStyle.textSecondaryFontSizeBold(12.sp,
                  color:
                      type == 'LIKE' ? colorPink : textColor ?? colorSecondary),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 2.sp,
            ),
            child: Icon(
              icon,
              size: 15.sp,
              color: color,
            ),
          )
        ],
      ),
    );
  }
}
