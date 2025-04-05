
part of '../model/meal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


MainMenuMeal _$MainMenuMealFromJson(Map<String, dynamic> json) => MainMenuMeal(
    mostLikeMeals: json['mostLikeMeals'] != null ? (json['mostLikeMeals'] as List).map((e) => Meal.fromJson(e),).toList() : [],
    tookMostTimeMeals: json['tookMostTimeMeals'] != null ? (json['tookMostTimeMeals'] as List).map((e) => Meal.fromJson(e),).toList() : [],
    veganMeals: json['veganMeals'] != null ? (json['veganMeals'] as List).map((e) => Meal.fromJson(e),).toList() : [],
    listMeals: json['listMeals'] != null ? (json['listMeals'] as List).map((e) => Meal.fromJson(e),).toList() : []
);

Map<String, dynamic> _$MainMenuMealToJson(MainMenuMeal instance) => <String, dynamic>{
  'mostLikeMeals': instance.mostLikeMeals,
  'tookMostTimeMeals': instance.tookMostTimeMeals,
  'veganMeals': instance.veganMeals,
  'listMeals': instance.listMeals,
};

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
      mealID: json['mealID'] as String?,
      mealName: json['mealName'] as String?,
      method:
          (json['method'] as List<dynamic>?)?.map((e) => e as String).toList(),
      image: json['image'] as String?,
      totalTime: (json['totalTime'] as num?)?.toInt(),
      totalLike: (json['totalLike'] as num?)?.toInt(),
      isVegan: json['isVegan'] ?? false
    );

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
      'mealID': instance.mealID,
      'mealName': instance.mealName,
      'method': instance.method,
      'image': instance.image,
      'totalTime': instance.totalTime,
      'totalLike': instance.totalLike,
      'isVegan': instance.isVegan
    };
