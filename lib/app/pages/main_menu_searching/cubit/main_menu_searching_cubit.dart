import 'package:bloc/bloc.dart';

import 'package:cooking_project/data/repository/meal_repository.dart';

import '../../../../domain/entities/meal_model.dart';
import 'main_menu_searching_state.dart';


class MainMenuCubit extends Cubit<MainMenuSearchingState>{


  MainMenuCubit()  : super(MainMenuSearchingEmpty());


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