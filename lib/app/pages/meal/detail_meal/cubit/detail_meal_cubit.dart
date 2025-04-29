import 'package:bloc/bloc.dart';

import 'detail_meal_state.dart';


class DetailMealCubit extends Cubit<DetailMealState>{
  DetailMealCubit()  : super(DetailMealEmpty());

  void changeIndex(int index){
    emit(DetailMealEmpty());
    emit(DetailMealIndexChange(index: index));
  }

  void likeMeal({required bool isLiked}){
    emit(DetailMealEmpty());
    emit(DetailMealLikeMeal(isLiked: isLiked));
  }
}