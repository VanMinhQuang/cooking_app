import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../domain/entities/meal_model.dart';
import '../../../widgets/bar/main_app_bar.dart';
import '../../../widgets/carousel/meal_carousel/meal_carousel.dart';
import '../../../widgets/stuffs/components.dart';
import '../cubit/main_menu_searching_cubit.dart';
import '../cubit/main_menu_searching_state.dart';
import '../widgets/meal_widgets.dart';

class MainMenuSearchingForm extends StatefulWidget {
  const MainMenuSearchingForm({super.key});

  @override
  State<MainMenuSearchingForm> createState() => _MainMenuSearchingFormState();
}

class _MainMenuSearchingFormState extends State<MainMenuSearchingForm> {
  MainMenuMeal? mealList;
  bool? isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MainMenuCubit>().loadListFood();
    });
  }

  Future<void> _refresIndicator() async {
    context.read<MainMenuCubit>().loadListFood();
  }

  void fetchMore() {
    print('Fetch More');
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
        appBar: const CustomMealAppBar(isHaveSearchField: true),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(10.sp),
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
                    SectionTitle(
                      title: 'Món ăn yêu thích nhất',
                      icon: Icons.favorite,
                      bgColor: Colors.red,
                    ),
                    Skeletonizer(
                      enabled: isLoading ?? false,
                      child: MealCarouselWidget(
                        mealList: mealList?.tookMostTimeMeals ?? [],
                        type: 'FAVORITE',
                      ),
                    ),
                    Components.separateLine(),
                    SectionTitle(
                      title: 'Món ăn dành cho người thực vật',
                      icon: Icons.eco,
                      bgColor: Colors.green,
                    ),
                    Skeletonizer(
                      enabled: isLoading ?? false,
                      child: MealCarouselWidget(
                        mealList: mealList?.tookMostTimeMeals ?? [],
                        type: 'FAVORITE',
                      ),
                    ),
                    Components.separateLine(),
                    SectionTitle(
                      title: 'Danh mục',
                      bgColor: Colors.grey,
                      paddingBottom: 3,
                    ),
                    MealList(
                      meals: mealList?.listMeals ?? [],
                      onFetchMore: fetchMore,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
