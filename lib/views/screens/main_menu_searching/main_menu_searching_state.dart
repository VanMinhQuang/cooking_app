import 'package:cooking_project/data/model/Food.dart';
import 'package:cooking_project/data/model/meal_model.dart';
import 'package:equatable/equatable.dart';

abstract class MainMenuSearchingState extends Equatable{
  const MainMenuSearchingState();
  @override
  List<Object> get props => [];
}

class MainMenuSearchingEmpty  extends MainMenuSearchingState {}

class MainMenuSearchingLoading extends MainMenuSearchingState {}

class MainMenuSearchingLoaded extends MainMenuSearchingState{
  final List<Meal> foods;
  const MainMenuSearchingLoaded({required this.foods});
  @override
  List<Object> get props => [foods];
}

class MainMenuSearchingError extends MainMenuSearchingState{
  final String error;

  const MainMenuSearchingError({required this.error});

  @override
  List<Object> get props => [error];
}
