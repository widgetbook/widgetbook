import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/themes/dark_theme.dart';
import 'package:meal_app/themes/light_theme.dart';
import 'package:meal_app/widgets/attributes/price_attribute.dart';
import 'package:meal_app/widgets/attributes/weight_attribute.dart';
import 'package:meal_app/widgets/ingredients.dart';
import 'package:meal_app/widgets/meal_detail.dart';
import 'package:meal_app/widgets/new_tag.dart';
import 'package:meal_app/widgets/rotated_image.dart';

class Storyboard extends StatelessWidget {
  const Storyboard({Key? key}) : super(key: key);

  Widget buildStorybook(BuildContext context) {
    return Widgetbook(
      devices: [
        Apple.iPhone11,
        Apple.iPhone12,
        Samsung.s10,
        Samsung.s21ultra,
      ],
      categories: [
        Category(
          name: 'widgets',
          folders: [
            Folder(
              name: 'attributes',
              widgets: [
                WidgetElement(
                  name: 'PriceAttribute',
                  stories: [
                    Story(
                      name: 'Short price',
                      builder: (context) => PriceAttribute(price: 8.5),
                    ),
                    Story(
                      name: 'Long price',
                      builder: (context) => PriceAttribute(price: 108.5),
                    ),
                  ],
                ),
                WidgetElement(
                  name: 'WeightAttribute',
                  stories: [
                    Story(
                      name: 'Short weight',
                      builder: (context) => WeightAttribute(
                        weight: 320,
                      ),
                    ),
                    Story(
                      name: 'Long weight',
                      builder: (context) => WeightAttribute(
                        weight: 1050,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
          widgets: [
            WidgetElement(
              name: 'Ingredients',
              stories: [
                Story(
                  name: 'Short list',
                  builder: (context) => Ingredients(
                    ingredients: [
                      'tomato',
                      'beef',
                      'onion',
                    ],
                  ),
                ),
                Story(
                  name: 'Medium list',
                  builder: (context) => Ingredients(
                    ingredients: [
                      'tomato',
                      'beef',
                      'onion',
                      'mustard',
                      'cheese',
                      'sauce'
                    ],
                  ),
                ),
                Story(
                  name: 'Long list',
                  builder: (context) => Ingredients(
                    ingredients: [
                      'tomato',
                      'beef',
                      'onion',
                      'mustard',
                      'cheese',
                      'sauce',
                      'olives',
                      'bread',
                      'bacon',
                    ],
                  ),
                ),
              ],
            ),
            WidgetElement(
              name: 'New tag',
              stories: [
                Story(
                  name: 'Default',
                  builder: (context) => NewTag(),
                ),
              ],
            ),
            WidgetElement(
              name: 'Rotated image',
              stories: [
                Story(
                  name: 'Default',
                  builder: (context) => RotatedImage(
                    assetPath: 'assets/burger.jpg',
                  ),
                ),
              ],
            ),
            WidgetElement(
              name: 'MealDetail',
              stories: [
                Story(
                  name: 'Short name',
                  builder: (context) => MealDetail(
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
                  ),
                ),
                Story(
                  name: 'Long name',
                  builder: (context) => MealDetail(
                    meal: Meal(
                      title: 'Bacon Burger with cheese and onions',
                      imagePath: 'assets/burger.jpg',
                      ingredients: [
                        'tomato',
                        'beef',
                        'onion',
                      ],
                      price: 8.5,
                      weight: 320,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Category(
          name: 'pages',
        ),
      ],
      appInfo: AppInfo(name: 'Meal App'),
      lightTheme: getLightTheme(context),
      darkTheme: getDarkTheme(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildStorybook(context);
  }
}
