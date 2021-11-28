import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: const Text('hello world'),
    );
  }
}

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      devices: [
        Devices.ios.iPhone12,
        Devices.ios.iPhone12Mini,
        Devices.ios.iPhone12ProMax,
        Devices.android.samsungS20,
        Devices.linux.laptop,
      ],
      categories: [
        WidgetbookCategory(
          name: 'widgets',
          widgets: [
            WidgetbookWidget(
              name: '$CustomWidget',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => const CustomWidget(),
                ),
              ],
            ),
          ],
          folders: [
            WidgetbookFolder(
              name: 'Texts',
              widgets: [
                WidgetbookWidget(
                  name: 'Normal Text',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Default',
                      builder: (context) => const Text(
                        'The brown fox ...',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
      appInfo: AppInfo(
        name: 'Widgetbook Example',
      ),
    );
  }
}

void main() {
  runApp(const HotReload());
}
