import 'package:json_annotation/json_annotation.dart';

part '../model_json/meal_model.g.dart';

@JsonSerializable()
class Meal{
  String? mealID;
  String? mealName;
  List<String>? method;
  String? image;
  int? totalTime;
  int? totalLike;

  Meal({this.mealID, this.mealName, this.method, this.image, this.totalTime, this.totalLike});

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);

}