import 'package:equatable/equatable.dart';

abstract class DailyMealState extends Equatable{
  const DailyMealState();
  @override
  List<Object> get props => [];
}

class DailyMealEmptyState extends DailyMealState {}

class DailyMealLoading extends DailyMealState {}

class DailyMealLoaded extends DailyMealState{
}