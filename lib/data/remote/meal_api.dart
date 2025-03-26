import 'dart:convert';

import 'package:cooking_project/core/service/service.dart';
import 'package:cooking_project/data/model/meal_model.dart';
import 'package:cooking_project/data/url/controller_url.dart';
import 'package:http/http.dart' as http;
class MealAPI extends Service{
  Future<List<Meal>?> getMeals() async {
    var url = '${apiUrl()}${CONTROLLER_URL.MEAL_CONTROLLER}';

    var createHeaderRequest= await createHeaderUnAuthorization();
    try{
      var response = await http.get(Uri.parse(url),headers: createHeaderRequest).timeout(Duration(seconds: 30));
      var responeBody = responseBody(response);
      
      return (jsonDecode(responeBody) as List).map((e) => Meal.fromJson(e)).toList();
    }catch(e){
      var info = e.toString();
      throw info;
    }
  }
}