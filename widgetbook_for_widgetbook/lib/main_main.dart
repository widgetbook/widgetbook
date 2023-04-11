import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const HotReloadClass());
}

class HotReloadClass extends StatelessWidget {
  const HotReloadClass({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HotReload(),
    );
  }
}

class HotReload extends StatelessWidget {
  const HotReload({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        MaterialThemeAddon(
          setting: ThemeSetting.firstAsSelected(
            themes: [WidgetbookTheme(name: 'Dark', data: ThemeData.dark())],
          ),
        ),
        FrameAddon(
          setting: FrameSetting.firstAsSelected(
            frames: [
              DefaultDeviceFrame(
                setting: DeviceSetting.firstAsSelected(
                  devices: [
                    Apple.iPhone11,
                    Apple.iPhone11Pro,
                    Apple.iPhone12,
                    Apple.iPhone12Mini,
                    Apple.iPhone12Pro,
                    Apple.iPhone12ProMax,
                    Apple.iPhone13,
                    Apple.iPhone13Mini,
                    Apple.iPhone13Pro,
                    Apple.iPhone13ProMax,
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      directories: [
        WidgetbookComponent(
          name: 'Button 2',
          useCases: [
            WidgetbookUseCase(
              name: 'Default 1',
              builder: (context) => Center(
                child: ElevatedButton(
                  style: context.knobs.options(
                    label: 'Style',
                    options: [
                      ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.green),
                      ),
                      ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                    ],
                  ),
                  onPressed: () {},
                  child: Text(
                    context.knobs.text(
                      label: 'Text',
                      description: 'Button label',
                      initialValue: 'Click Me',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        WidgetbookComponent(
          name: 'Button',
          useCases: [
            WidgetbookUseCase(
              name: 'Default 111111',
              builder: (context) => Center(
                child: ElevatedButton(
                  style: context.knobs.options(
                    label: 'Style',
                    options: [
                      ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.green),
                      ),
                      ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                    ],
                  ),
                  onPressed: () {},
                  child: Text(
                    context.knobs.text(
                      label: 'Text',
                      description: 'Button label',
                      initialValue: 'Click Me',
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class EmptyResultWidget extends StatelessWidget {
  const EmptyResultWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.baseColor,
    required this.onRefresh,
  });
  final IconData icon;
  final String title;
  final Color baseColor;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: baseColor,
            size: 100,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: baseColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          if (null != onRefresh)
            IconButton(
              onPressed: onRefresh,
              icon: const Icon(
                Icons.add,
                color: Colors.blueGrey,
              ),
              iconSize: 30,
            )
          else
            const SizedBox()
        ],
      ),
    );
  }
}
