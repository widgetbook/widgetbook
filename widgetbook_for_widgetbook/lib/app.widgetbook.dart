// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// WidgetbookGenerator
// **************************************************************************

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/src/settings/features/knobs/knob_padding.dart';
import 'package:widgetbook_core/src/settings/features/knobs/knob_property.dart';
import 'package:widgetbook_core/src/settings/models/settings_panel_data.dart';
import 'package:widgetbook_core/src/settings/widgets/widgets.dart';
import 'package:widgetbook_core/widgetbook_core.dart';
import 'package:widgetbook_for_widgetbook/app.dart';
import 'package:widgetbook_for_widgetbook/navigation/expander_button.dart';
import 'package:widgetbook_for_widgetbook/navigation/navigation_panel.dart';
import 'package:widgetbook_for_widgetbook/navigation/navigation_tree.dart';
import 'package:widgetbook_for_widgetbook/navigation/navigation_tree_item.dart';
import 'package:widgetbook_for_widgetbook/navigation/navigation_tree_node.dart';
import 'package:widgetbook_for_widgetbook/search/search.dart';
import 'package:widgetbook_for_widgetbook/settings/features/knobs/bool_knob.widgetbook.dart';
import 'package:widgetbook_for_widgetbook/settings/features/knobs/color_knob.widgetbook.dart';
import 'package:widgetbook_for_widgetbook/settings/features/knobs/number_knob.widgetbook.dart';
import 'package:widgetbook_for_widgetbook/settings/features/knobs/option_knob.widgetbook.dart';
import 'package:widgetbook_for_widgetbook/settings/features/knobs/slider_knob.widgetbook.dart';
import 'package:widgetbook_for_widgetbook/settings/features/knobs/text_knob.widgetbook.dart';
import 'package:widgetbook_for_widgetbook/settings/features/widgets/complex_setting.widgetbook.dart';
import 'package:widgetbook_for_widgetbook/settings/features/widgets/dropdown_setting.widgetbook.dart';
import 'package:widgetbook_for_widgetbook/settings/features/widgets/setting_group.widgetbook.dart';
import 'package:widgetbook_for_widgetbook/settings/features/widgets/setting_header.widgetbook.dart';
import 'package:widgetbook_for_widgetbook/settings/features/widgets/setting_section.widgetbook.dart';
import 'package:widgetbook_for_widgetbook/settings/features/widgets/settings_panel.widgetbook.dart';

void main() {
  runApp(HotReload());
}

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        CustomThemeAddon<ThemeData>(
          setting: ThemeSetting<ThemeData>(
            themes: [
              WidgetbookTheme(
                name: 'Dark',
                data: themeDark(),
              ),
              WidgetbookTheme(
                name: 'Light',
                data: themeLight(),
              ),
            ],
            activeTheme: WidgetbookTheme(
              name: 'Dark',
              data: themeDark(),
            ),
          ),
        ),
        TextScaleAddon(
          setting: TextScaleSetting(
            textScales: [
              1.0,
              2.0,
            ],
            activeTextScale: 1.0,
          ),
        ),
        FrameAddon(
          setting: FrameSetting(
            frames: [
              NoFrame(),
              DefaultDeviceFrame(
                setting: DeviceSetting(
                  devices: [
                    Device(
                      name: 'iPhone 11',
                      resolution: Resolution(
                        nativeSize: DeviceSize(
                          height: 1792.0,
                          width: 828.0,
                        ),
                        scaleFactor: 2.0,
                      ),
                      type: DeviceType.mobile,
                    ),
                    Device(
                      name: 'iPhone 12',
                      resolution: Resolution(
                        nativeSize: DeviceSize(
                          height: 2532.0,
                          width: 1170.0,
                        ),
                        scaleFactor: 3.0,
                      ),
                      type: DeviceType.mobile,
                    ),
                    Device(
                      name: 'iPhone 13',
                      resolution: Resolution(
                        nativeSize: DeviceSize(
                          height: 2532.0,
                          width: 1170.0,
                        ),
                        scaleFactor: 3.0,
                      ),
                      type: DeviceType.mobile,
                    ),
                  ],
                  activeDevice: Device(
                    name: 'iPhone 11',
                    resolution: Resolution(
                      nativeSize: DeviceSize(
                        height: 1792.0,
                        width: 828.0,
                      ),
                      scaleFactor: 2.0,
                    ),
                    type: DeviceType.mobile,
                  ),
                ),
              ),
              WidgetbookFrame(
                setting: DeviceSetting(
                  devices: [
                    Device(
                      name: 'iPhone 11',
                      resolution: Resolution(
                        nativeSize: DeviceSize(
                          height: 1792.0,
                          width: 828.0,
                        ),
                        scaleFactor: 2.0,
                      ),
                      type: DeviceType.mobile,
                    ),
                    Device(
                      name: 'iPhone 12',
                      resolution: Resolution(
                        nativeSize: DeviceSize(
                          height: 2532.0,
                          width: 1170.0,
                        ),
                        scaleFactor: 3.0,
                      ),
                      type: DeviceType.mobile,
                    ),
                    Device(
                      name: 'iPhone 13',
                      resolution: Resolution(
                        nativeSize: DeviceSize(
                          height: 2532.0,
                          width: 1170.0,
                        ),
                        scaleFactor: 3.0,
                      ),
                      type: DeviceType.mobile,
                    ),
                  ],
                  activeDevice: Device(
                    name: 'iPhone 11',
                    resolution: Resolution(
                      nativeSize: DeviceSize(
                        height: 1792.0,
                        width: 828.0,
                      ),
                      scaleFactor: 2.0,
                    ),
                    type: DeviceType.mobile,
                  ),
                ),
              ),
            ],
            activeFrame: NoFrame(),
          ),
        ),
      ],
      directories: [
        WidgetbookFolder(
          name: 'search',
          children: [
            WidgetbookFolder(
              name: 'widgets',
              children: [
                WidgetbookComponent(
                  name: 'SearchField',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Default',
                      builder: (context) => searchFieldDefaultUseCase(context),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'icons',
          children: [
            WidgetbookComponent(
              name: 'ExpanderIcon',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => expanderButton(context),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'navigation_tree',
          children: [
            WidgetbookFolder(
              name: 'widgets',
              children: [
                WidgetbookComponent(
                  name: 'NavigationTree',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Default',
                      builder: (context) =>
                          navigationTreeDefaultUseCase(context),
                    ),
                  ],
                ),
                WidgetbookComponent(
                  name: 'NavigationTreeNode',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Default',
                      builder: (context) =>
                          navigationTreeNodeDefaultUseCase(context),
                    ),
                  ],
                ),
                WidgetbookComponent(
                  name: 'NavigationTreeItem',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Default',
                      builder: (context) => navigationTreeItemWithout(context),
                    ),
                  ],
                ),
                WidgetbookComponent(
                  name: 'NavigationPanel',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Default',
                      builder: (context) =>
                          navigationPanelDefaultUseCase(context),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'settings',
          children: [
            WidgetbookFolder(
              name: 'widgets',
              children: [
                WidgetbookComponent(
                  name: 'SettingSection',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Default',
                      builder: (context) => settingSection(context),
                    ),
                  ],
                ),
                WidgetbookComponent(
                  name: 'ComplexSetting',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Default',
                      builder: (context) => complexSettingUseCase(context),
                    ),
                  ],
                ),
                WidgetbookComponent(
                  name: 'SettingHeader',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Text only',
                      builder: (context) => textOnly(context),
                    ),
                    WidgetbookUseCase(
                      name: 'with Trailing',
                      builder: (context) => trailing(context),
                    ),
                  ],
                ),
                WidgetbookComponent(
                  name: 'SettingsPanel',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Default',
                      builder: (context) => settingsPanel(context),
                    ),
                  ],
                ),
                WidgetbookComponent(
                  name: 'DropdownSetting<dynamic>',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Test',
                      builder: (context) => test(context),
                    ),
                  ],
                ),
                WidgetbookComponent(
                  name: 'SettingGroup',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'default',
                      builder: (context) => settingGroupUseCase(context),
                    ),
                  ],
                ),
              ],
            ),
            WidgetbookFolder(
              name: 'features',
              children: [
                WidgetbookFolder(
                  name: 'knobs',
                  children: [
                    WidgetbookComponent(
                      name: 'TextKnob',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) => textKnob(context),
                        ),
                      ],
                    ),
                    WidgetbookComponent(
                      name: 'SliderKnob',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) => sliderKnob(context),
                        ),
                      ],
                    ),
                    WidgetbookComponent(
                      name: 'NullableNumberKnob',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) => nullableNumberKniob(context),
                        ),
                      ],
                    ),
                    WidgetbookComponent(
                      name: 'NullableBoolKnob',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) => nullableBoolKnob(context),
                        ),
                      ],
                    ),
                    WidgetbookComponent(
                      name: 'NullableTextKnob',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) => nullableTextKnob(context),
                        ),
                      ],
                    ),
                    WidgetbookComponent(
                      name: 'ColorKnob',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) => colorKnob(context),
                        ),
                      ],
                    ),
                    WidgetbookComponent(
                      name: 'OptionKnob<dynamic>',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) => optionKnob(context),
                        ),
                      ],
                    ),
                    WidgetbookComponent(
                      name: 'BoolKnob',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) => boolKnob(context),
                        ),
                      ],
                    ),
                    WidgetbookComponent(
                      name: 'NumberKnob',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) => numberKnob(context),
                        ),
                      ],
                    ),
                    WidgetbookComponent(
                      name: 'NullableSliderKnob',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) => nullableSliderKnob(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
      appBuilder: customAppBuilder,
    );
  }
}
