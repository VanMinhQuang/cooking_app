class Food {
  String? foodId;
  String? foodName;
  List<String>? category;
  String? image;
  String? descr;


  Food({this.foodId, this.foodName, this.category, this.image, this.descr});

  static List<Food> foodList = [
    Food(
        foodId: "1",
        foodName: "Grilled Chicken Salad",
        category: ["Healthy", "Low-Carb"],
        image: "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
        descr: "A delicious and nutritious grilled chicken salad."
    ),
    Food(
        foodId: "2",
        foodName: "French Fries",
        category: ["Deep-Fried", "Snack","Breakfast","Fast Food","Oiled","French","BLA BLA BLA BLA"],
        image: "https://images.pexels.com/photos/1583884/pexels-photo-1583884.jpeg",
        descr: "Crispy golden fries served hot and fresh."
    ),
    Food(
        foodId: "3",
        foodName: "Avocado Toast",
        category: ["Healthy", "Breakfast"],
        image: "https://images.pexels.com/photos/2228434/pexels-photo-2228434.jpeg",
        descr: "Creamy avocado spread over crispy toast."
    ),
    Food(
        foodId: "4",
        foodName: "Cheeseburger",
        category: ["Fast Food", "Grilled"],
        image: "https://images.pexels.com/photos/1639557/pexels-photo-1639557.jpeg",
        descr: "Juicy beef patty with melted cheese and fresh toppings."
    ),
    Food(
        foodId: "5",
        foodName: "Sushi Roll",
        category: ["Healthy", "Seafood"],
        image: "https://images.pexels.com/photos/616401/pexels-photo-616401.jpeg",
        descr: "Fresh sushi roll made with premium ingredients."
    ),
    Food(
        foodId: "6",
        foodName: "Fried Chicken",
        category: ["Deep-Fried", "Comfort Food"],
        image: "https://images.pexels.com/photos/3872370/pexels-photo-3872370.jpeg",
        descr: "Crispy, golden fried chicken with a flavorful crust."
    ),
  ];

}