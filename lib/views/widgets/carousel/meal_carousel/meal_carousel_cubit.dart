import 'package:bloc/bloc.dart';
import 'package:cooking_project/views/widgets/carousel/meal_carousel/meal_carousel_state.dart';

class MealCarouselCubit extends Cubit<MealCarouselState>{
  MealCarouselCubit() : super(MealCarouselEmpty());


  void updateIndicator(int index){
    emit(MealCarouselEmpty());
    emit(MealCarouselIndicatorChanged(index: index));
  }
}