import 'package:cooking_project/data/model/recipe.dart';

class MealStep {
  int? stepIndex;
  String? descr;
  String? method;
  bool? isDone;
  int? time;
  String? videoUrl;
  List<RecipeGram>? listRecipe;
  MealStep(
      {required this.stepIndex,
      required this.descr,
      required this.method,
      required this.time,
      required this.videoUrl,
      required this.isDone,
      required this.listRecipe});

  List<MealStep> mockMealSteps = [
    MealStep(
      stepIndex: 0,
      descr: "Prepare the ingredients",
      method: "",
      time: 60,
      videoUrl: "",
      isDone: false,
      listRecipe: [
        RecipeGram(
          recipe: Recipe(
            recipeID: "r1",
            recipeName: "Tomato",
            calories: 18,
            fat: 0.2,
            fiber: 1.2,
            carb: 3.9,
          ),
          gram: 150,
        ),
        RecipeGram(
          recipe: Recipe(
            recipeID: "r2",
            recipeName: "Cucumber",
            calories: 16,
            fat: 0.1,
            fiber: 0.5,
            carb: 3.6,
          ),
          gram: 100,
        ),
      ],
    ),
    MealStep(
      stepIndex: 1,
      descr: "Cook the vegetables",
      method: "Stir",
      time: 60,
      videoUrl: "",
      isDone: false,
      listRecipe: [
        RecipeGram(
          recipe: Recipe(
            recipeID: "r3",
            recipeName: "Olive Oil",
            calories: 119,
            fat: 13.5,
            fiber: 0,
            carb: 0,
          ),
          gram: 15,
        ),
      ],
    ),
    MealStep(
      stepIndex: 2,
      descr: "Serve the dish",
      method: "",
      time: 60,
      videoUrl: "",
      isDone: false,
      listRecipe: [
        RecipeGram(
          recipe: Recipe(
            recipeID: "r4",
            recipeName: "Lemon Juice",
            calories: 4,
            fat: 0,
            fiber: 0.1,
            carb: 1.3,
          ),
          gram: 10,
        ),
      ],
    ),
  ];
}

class RecipeGram {
  Recipe? recipe;
  double? gram;

  RecipeGram({this.recipe, this.gram});
}
