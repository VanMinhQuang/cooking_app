
part of '../model/meal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
