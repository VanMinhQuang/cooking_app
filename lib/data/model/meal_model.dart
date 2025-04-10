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
  bool? isVegan;

  Meal({this.mealID, this.mealName, this.method, this.image, this.isVegan , this.totalTime, this.totalLike});

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);

}

@JsonSerializable()
class MainMenuMeal{
  List<Meal>? mostLikeMeals;
  List<Meal>? tookMostTimeMeals;
  List<Meal>? veganMeals;
  List<Meal>? listMeals;

  MainMenuMeal({this.mostLikeMeals, this.tookMostTimeMeals, this.veganMeals, this.listMeals});

  factory MainMenuMeal.fromJson(Map<String, dynamic> json) => _$MainMenuMealFromJson(json);

  Map<String, dynamic> toJson() => _$MainMenuMealToJson(this);

  static MainMenuMeal generateStaticData() {
    return MainMenuMeal(
      mostLikeMeals: List.generate(16, (index) => Meal(
        mealID: 'meal$index',
        mealName: 'Meal Name $index',
        method: ['Cook', 'Serve'],
        image: 'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        totalTime: 30 + index,
        totalLike: 100 + (index * 10),
        isVegan: index.isEven,
      )),
      tookMostTimeMeals: List.generate(15, (index) => Meal(
        mealID: 'meal$index',
        mealName: 'Meal Name $index',
        method: ['Cook', 'Serve'],
        image: 'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        totalTime: 50 + index,
        totalLike: 50 + (index * 5),
        isVegan: index.isOdd,
      )),
      veganMeals: List.generate(16, (index) => Meal(
        mealID: 'meal$index',
        mealName: 'Vegan Meal Name $index',
        method: ['Cook', 'Serve'],
        image: 'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        totalTime: 25 + index,
        totalLike: 80 + (index * 8),
        isVegan: true,
      )),
      listMeals: List.generate(20, (index) => Meal(
        mealID: 'meal$index',
        mealName: 'List Meal Name $index',
        method: ['Cook', 'Serve'],
        image: 'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        totalTime: 20 + index,
        totalLike: 60 + (index * 6),
        isVegan: index.isEven,
      )),
    );
  }
}