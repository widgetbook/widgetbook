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
      defaultTheme: ThemeMode.dark,
      devices: [
        Apple.iPhone11,
        Apple.iPhone12,
        Samsung.s10,
        Samsung.s21ultra,
        Apple.iMacM1,
      ],
      categories: [
        WidgetbookCategory(
          name: 'widgets test',
          folders: [
            WidgetbookFolder(
              name: 'attributes',
              widgets: [
                WidgetbookWidget(
                  name: 'PriceAttribute',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Short price',
                      builder: (context) => PriceAttribute(price: 8.5),
                    ),
                    WidgetbookUseCase(
                      name: 'Long price',
                      builder: (context) => PriceAttribute(price: 108.5),
                    ),
                  ],
                ),
                WidgetbookWidget(
                  name: 'WeightAttribute',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Short weight',
                      builder: (context) => WeightAttribute(
                        weight: 320,
                      ),
                    ),
                    WidgetbookUseCase(
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
            WidgetbookWidget(
              name: 'Ingredients',
              useCases: [
                WidgetbookUseCase(
                  name: 'Short list',
                  builder: (context) => Ingredients(
                    ingredients: [
                      'tomato',
                      'beef',
                      'onion',
                    ],
                  ),
                ),
                WidgetbookUseCase(
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
                WidgetbookUseCase(
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
            WidgetbookWidget(
              name: 'New tag',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => NewTag(),
                ),
              ],
            ),
            WidgetbookWidget(
              name: 'Rotated image',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => RotatedImage(
                    assetPath: 'assets/burger.jpg',
                  ),
                ),
              ],
            ),
            WidgetbookWidget(
              name: 'MealDetail',
              useCases: [
                WidgetbookUseCase(
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
                WidgetbookUseCase(
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
        WidgetbookCategory(
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
