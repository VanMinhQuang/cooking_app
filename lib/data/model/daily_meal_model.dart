import 'package:cooking_project/data/model/meal_model.dart';

class DailyMeal{
  List<CaloriesToHit>? listCalories;
  DailyMeal({required this.listCalories});

  static DailyMeal generateData(){
   DailyMeal dailyMeals =
      DailyMeal(
          listCalories: [
            CaloriesToHit(target: 2000, actual: 1800, dayOfWeek: 'Mon', date: DateTime(2025, 4, 6)),
            CaloriesToHit(target: 2000, actual: 2100, dayOfWeek: 'Tue', date: DateTime(2025, 4, 7)),
            CaloriesToHit(target: 2000, actual: 2000, dayOfWeek: 'Wed', date: DateTime(2025, 4, 8)),
            CaloriesToHit(target: 2000, actual: 1700, dayOfWeek: 'Thu', date: DateTime(2025, 4, 9)),
            CaloriesToHit(target: 2000, actual: 2200, dayOfWeek: 'Fri', date: DateTime(2025, 4, 10)),
            CaloriesToHit(target: 2000, actual: 0, dayOfWeek: 'Sat', date: DateTime(2025, 4, 9)),
            CaloriesToHit(target: 2000, actual: 0, dayOfWeek: 'Sun', date: DateTime(2025, 4, 10)),
          ]
      );

    return dailyMeals;
  }
}


class CaloriesToHit{
  double? target;
  double? actual;
  String? dayOfWeek;
  DateTime? date;

  CaloriesToHit({required this.target, this.actual, this.dayOfWeek, this.date});
}

class CaloriesToDay {
  double? target;
  double? actual;
  double? fat;
  double? carb;
  double? protein;
}
class MealInDay{
  String? dayOfWeek;
  String? mealDay;
  String? mealTime;
  List<Meal>? meals;
}