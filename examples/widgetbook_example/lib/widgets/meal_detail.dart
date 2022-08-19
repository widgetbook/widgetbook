import 'package:flutter/material.dart';
import 'package:widgetbook_example/models/meal.dart';
import 'package:widgetbook_example/widgets/attributes/price_attribute.dart';
import 'package:widgetbook_example/widgets/attributes/weight_attribute.dart';
import 'package:widgetbook_example/widgets/ingredients.dart';
import 'package:widgetbook_example/widgets/new_tag.dart';
import 'package:widgetbook_example/widgets/rotated_image.dart';

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
          Expanded(
            child: RotatedImage(
              assetPath: meal.imagePath,
            ),
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
