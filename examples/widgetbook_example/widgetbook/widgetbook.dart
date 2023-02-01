import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_example/models/meal.dart';
import 'package:widgetbook_example/themes/dark_theme.dart';
import 'package:widgetbook_example/themes/light_theme.dart';
import 'package:widgetbook_example/widgets/attributes/multiline_knob.dart';
import 'package:widgetbook_example/widgets/attributes/price_attribute.dart';
import 'package:widgetbook_example/widgets/attributes/weight_attribute.dart';
import 'package:widgetbook_example/widgets/ingredients.dart';
import 'package:widgetbook_example/widgets/meal_detail.dart';
import 'package:widgetbook_example/widgets/new_tag.dart';
import 'package:widgetbook_example/widgets/rotated_image.dart';

void main() {
  runApp(const HotreloadWidgetbook());
}

class HotreloadWidgetbook extends StatelessWidget {
  const HotreloadWidgetbook({Key? key}) : super(key: key);

  Widget buildStorybook(BuildContext context) {
    final devices = [
      Apple.iPhone11,
      Apple.iPhone12,
      const Device.special(
        name: 'Test',
        resolution: Resolution(
          nativeSize: DeviceSize(width: 400, height: 400),
          scaleFactor: 1,
        ),
      ),
    ];

    return Widgetbook.material(
      addons: [
        ...configureMaterialAddons(
          themeSetting: MaterialThemeSetting.firstAsSelected(
            themes: [
              WidgetbookTheme(name: 'Light', data: lightTheme),
              WidgetbookTheme(name: 'Dark', data: darkTheme),
            ],
          ),
          frameSetting: FrameSetting.firstAsSelected(frames: [
            DefaultDeviceFrame(
              setting: DeviceSetting.firstAsSelected(devices: devices),
            ),
            NoFrame(),
            WidgetbookFrame(
              setting: DeviceSetting.firstAsSelected(devices: devices),
            )
          ]),
          textScaleSetting: TextScaleSetting.firstAsSelected(
            textScales: [
              1,
              2,
              3,
            ],
          ),
          localizationSetting: LocalizationSetting(
            activeLocale: const Locale('en'),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locales: [
              const Locale('en'),
              const Locale('de'),
              const Locale('fr'),
            ],
          ),
        ),
      ],
      directories: [
        WidgetbookCategory(
          name: 'widgets test',
          children: [
            WidgetbookFolder(
              name: 'attributes',
              children: [
                WidgetbookComponent(
                  name: 'PriceAttribute',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Short price',
                      builder: (context) => const PriceAttribute(price: 8.5),
                    ),
                    WidgetbookUseCase(
                      name: 'Long price',
                      builder: (context) => const PriceAttribute(price: 108.5),
                    ),
                  ],
                ),
                WidgetbookComponent(
                  name: 'WeightAttribute',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Short weight',
                      builder: (context) => const WeightAttribute(
                        weight: 320,
                      ),
                    ),
                    WidgetbookUseCase(
                      name: 'Long weight',
                      builder: (context) => const WeightAttribute(
                        weight: 1050,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Ingredients',
              useCases: [
                WidgetbookUseCase(
                  name: 'Shortl list ',
                  builder: (context) => const Ingredients(
                    ingredients: [
                      'tomato',
                      'beef',
                      'onion',
                    ],
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Medium list',
                  builder: (context) => const Ingredients(
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
                  builder: (context) => const Ingredients(
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
                  builder: (context) => const NewTag(),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Rotated image',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => const RotatedImage(
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
          children: [
            WidgetbookFolder(
              name: 'attributes',
              children: [
                WidgetbookComponent(
                  name: 'PriceAttribute',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Short price',
                      builder: (context) => const PriceAttribute(price: 8.5),
                    ),
                    WidgetbookUseCase(
                      name: 'Long price',
                      builder: (context) => const PriceAttribute(price: 108.5),
                    ),
                  ],
                ),
                WidgetbookComponent(
                  name: 'WeightAttribute',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Short weight',
                      builder: (context) => const WeightAttribute(
                        weight: 320,
                      ),
                    ),
                    WidgetbookUseCase(
                      name: 'Long weight',
                      builder: (context) => const WeightAttribute(
                        weight: 1050,
                      ),
                    ),
                  ],
                ),
                WidgetbookComponent(
                  name: 'Knobs',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Multiline Knob',
                      builder: (context) => const MultiLineKnob(),
                    ),
                    WidgetbookUseCase(
                      name: 'Color Knob',
                      builder: (context) => Icon(
                        Icons.thumb_up_sharp,
                        color: context.knobs.color(
                          label: 'Color',
                          initialValue: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildStorybook(context);
  }
}
