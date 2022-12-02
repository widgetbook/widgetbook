import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_example/models/meal.dart';
import 'package:widgetbook_example/themes/dark_theme.dart';
import 'package:widgetbook_example/themes/light_theme.dart';
import 'package:widgetbook_example/widgets/attributes/price_attribute.dart';
import 'package:widgetbook_example/widgets/attributes/weight_attribute.dart';
import 'package:widgetbook_example/widgets/ingredients.dart';
import 'package:widgetbook_example/widgets/meal_detail.dart';
import 'package:widgetbook_example/widgets/new_tag.dart';
import 'package:widgetbook_example/widgets/rotated_image.dart';

void main() {
  runApp(HotreloadWidgetbook());
}

class HotreloadWidgetbook extends StatelessWidget {
  const HotreloadWidgetbook({Key? key}) : super(key: key);

  Widget buildStorybook(BuildContext context) {
    final devices = [
      Apple.iPhone11,
      Apple.iPhone12,
      Device.special(
        name: 'Test',
        resolution: Resolution(
          nativeSize: DeviceSize(width: 400, height: 400),
          scaleFactor: 1,
        ),
      ),
    ];
    final deviceFrameBuilder = DeviceFrameBuilder(
      devices: devices,
    );
    final activeFrameBuilder = WidgetbookFrameBuilder(
      devices: devices,
    );

    return Widgetbook.material(
      addons: [
        ...configureMaterialAddons(
          themeSetting: MaterialThemeSetting.firstAsSelected(
            themes: [
              WidgetbookTheme(name: 'Light', data: lightTheme),
              WidgetbookTheme(name: 'Dark', data: darkTheme),
              WidgetbookTheme(name: 'Darker', data: darkTheme3),
            ],
          ),
          textScaleSetting: TextScaleSetting.firstAsSelected(
            textScales: [
              1,
              2,
              3,
            ],
          ),
          localizationSetting: LocalizationSetting(
            activeLocales: {
              Locale('en'),
            },
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locales: [
              Locale('en'),
              Locale('de'),
              Locale('fr'),
            ],
          ),
          deviceSetting: DeviceSelection(
            activeFrameBuilder: activeFrameBuilder,
            frameBuilders: [
              activeFrameBuilder,
              deviceFrameBuilder,
            ],
          ),
        ),
      ],
      categories: [
        WidgetbookCategory(
          name: 'widgets test',
          folders: [
            WidgetbookFolder(
              name: 'attributes',
              widgets: [
                WidgetbookComponent(
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
                WidgetbookComponent(
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
            WidgetbookComponent(
              name: 'Ingredients',
              useCases: [
                WidgetbookUseCase(
                  name: 'Shortl list ',
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
            WidgetbookComponent(
              name: 'New tag',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => NewTag(),
                ),
              ],
            ),
            WidgetbookComponent(
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
            WidgetbookComponent(
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
          folders: [
            WidgetbookFolder(
              name: 'attributes',
              widgets: [
                WidgetbookComponent(
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
                WidgetbookComponent(
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
        ),
      ],
      appInfo: AppInfo(name: 'Meal App'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildStorybook(context);
  }
}
