import 'package:flutter/material.dart';
import 'package:widgetbook_example/models/meal.dart';
import 'package:widgetbook_example/pages/meal_page.dart';
import 'package:widgetbook_example/widgets/ingredients.dart';

class MealInfo extends StatelessWidget {
  final Meal meal;

  const MealInfo({
    Key? key,
    required this.meal,
  }) : super(key: key);

  Widget buildCard(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(meal.imagePath),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: 16,
                ),
                Ingredients(
                  ingredients: meal.ingredients,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: buildCard(context),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealPage(meal: meal),
          ),
        );
      },
    );
  }
}
