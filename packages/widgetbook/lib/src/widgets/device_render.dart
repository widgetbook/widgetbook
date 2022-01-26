import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/src/localization/localization.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/workbench/workbench.dart';

class DeviceRender extends ConsumerWidget {
  const DeviceRender({
    Key? key,
    required this.story,
  }) : super(key: key);

  final WidgetbookUseCase story;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final device = ref.watch(workbenchProvider).device!;

    final workbenchState = ref.watch(workbenchProvider);
    final localizationState = ref.watch(localizationProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(device.name),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          width: device.resolution.logicalSize.width,
          height: device.resolution.logicalSize.height,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: workbenchState.locale,
            localizationsDelegates: localizationState.localizationsDelegates,
            supportedLocales: localizationState.supportedLocales,
            home: AnimatedTheme(
              duration: Duration.zero,
              data: workbenchState.theme!.data,
              child: Scaffold(
                body: story.builder(
                  context,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
