import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/attributes/price_attribute.dart';
import 'package:meal_app/widgets/attributes/weight_attribute.dart';
import 'package:meal_app/widgets/ingredients.dart';
import 'package:meal_app/widgets/new_tag.dart';
import 'package:meal_app/widgets/rotated_image.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@WidgetbookUseCase(name: 'short name', type: MealDetail)
Widget mealDetailShort(BuildContext context) {
  return MealDetail(
    meal: Meal(
      title: 'Bacon Burger',
      imagePath: 'assets/burger.jpg',
      ingredients: [
        'tomato',
        'beef',
        'onion',
      ],
      price: 8.5,
      weight: 320,
    ),
  );
}

@WidgetbookUseCase(name: 'long name', type: MealDetail)
Widget mealDetailLong(BuildContext context) {
  return MealDetail(
    meal: Meal(
      title: 'Bacon Burger with onion rings and bacon',
      imagePath: 'assets/burger.jpg',
      ingredients: [
        'tomato',
        'beef',
        'onion',
      ],
      price: 8.5,
      weight: 320,
    ),
  );
}

class MealDetail extends StatelessWidget {
  final Meal meal;

  const MealDetail({
    Key? key,
    required this.meal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          RotatedImage(
            assetPath: meal.imagePath,
          ),
          SizedBox(
            height: 32,
          ),
          NewTag(),
          SizedBox(
            height: 16,
          ),
          Text(
            meal.title,
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 24,
          ),
          Ingredients(
            ingredients: meal.ingredients,
            centerText: true,
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PriceAttribute(
                price: meal.price,
              ),
              SizedBox(
                width: 32,
              ),
              WeightAttribute(
                weight: meal.weight,
              ),
            ],
          ),
          SizedBox(
            height: 32,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Taste it for \$${meal.price.toStringAsFixed(2)}',
            ),
          ),
        ],
      ),
    );
  }
}
