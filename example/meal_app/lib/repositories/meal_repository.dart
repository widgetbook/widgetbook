import 'package:meal_app/models/meal.dart';

class MealRepository {
  List<Meal> loadMeals() {
    return [
      Meal(
        title: 'Big double cheeseburger',
        imagePath: 'assets/burger.jpg',
        ingredients: [
          'marble beef',
          'cheddar cheese',
          'jalapeno pepper',
          'pickled cucumber',
          'letttuce',
          'red onion',
          'BBQ sauce',
        ],
        price: 8.5,
        weight: 320,
      ),
      Meal(
        title: 'Banana Pankakes',
        imagePath: 'assets/pancakes.jpg',
        ingredients: [
          'ripe bananas',
          'chilli chocolate',
          'brown sugar',
          'blueberries',
          'flour',
        ],
        price: 6.9,
        weight: 250,
      ),
    ];
  }
}
