

import 'package:equatable/equatable.dart';

import '../../../../domain/entities/meal_model.dart';

abstract class MainMenuSearchingState extends Equatable{
  const MainMenuSearchingState();
  @override
  List<Object> get props => [];
}

class MainMenuSearchingEmpty  extends MainMenuSearchingState {}

class MainMenuSearchingLoading extends MainMenuSearchingState {}

class MainMenuSearchingLoaded extends MainMenuSearchingState{
  final MainMenuMeal foods;
  const MainMenuSearchingLoaded({required this.foods});
  @override
  List<Object> get props => [foods];
}

class MainMenuIndicatorFavoriteChanged extends MainMenuSearchingState{
  int index;
  MainMenuIndicatorFavoriteChanged({required this.index});

  @override
  List<Object> get props => [index];
}

class MainMenuIndicatorVeganChanged extends MainMenuSearchingState{

  int index;
  MainMenuIndicatorVeganChanged({required this.index});

  @override
  List<Object> get props => [index];
}

class MainMenuSearchingError extends MainMenuSearchingState{
  final String error;

  const MainMenuSearchingError({required this.error});

  @override
  List<Object> get props => [error];
}
