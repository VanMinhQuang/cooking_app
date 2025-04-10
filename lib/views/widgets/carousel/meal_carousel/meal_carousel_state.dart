import 'package:equatable/equatable.dart';

abstract class MealCarouselState extends Equatable{
  const MealCarouselState();
  @override
  List<Object> get props => [];
}

class MealCarouselEmpty extends MealCarouselState{}
class MealCarouselIndicatorChanged extends MealCarouselState{

  int index;
  MealCarouselIndicatorChanged({required this.index});

  @override
  List<Object> get props => [index];
}