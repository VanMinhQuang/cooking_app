import 'package:bloc/bloc.dart';
import 'package:cooking_project/data/model/meal_model.dart';
import 'package:cooking_project/data/repository/meal_repository.dart';
import 'package:cooking_project/views/screens/main_menu_searching/main_menu_searching_state.dart';

class MainMenuCubit extends Cubit<MainMenuSearchingState>{

  final MealRepository mealRepository;
  MainMenuCubit({required this.mealRepository})  : super(MainMenuSearchingEmpty());


  void loadListFood() async {
    try{
      emit(MainMenuSearchingLoading());
      var meals = MainMenuMeal.generateStaticData(); //await mealRepository.getMeals();
      emit(MainMenuSearchingLoaded(foods: meals ?? MainMenuMeal()));
    }catch(e){
      emit(MainMenuSearchingError(error: e.toString()));
    }

  }


}