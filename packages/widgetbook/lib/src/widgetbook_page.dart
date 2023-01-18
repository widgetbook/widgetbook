import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon_injector_widget.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/settings_panel/settings_panel.dart';
import 'package:widgetbook/src/styled_widgets/styled_scaffold.dart';
import 'package:widgetbook/src/widgets/multi_split_view.dart';
import 'package:widgetbook/src/workbench/workbench.dart';
import 'package:widgetbook/widgetbook.dart';

class WidgetbookPage extends StatelessWidget {
  const WidgetbookPage({
    super.key,
    required this.disableNavigation,
    required this.disableProperties,
    required this.routerData,
  });

  final bool disableNavigation;
  final bool disableProperties;
  final Map<String, dynamic> routerData;

  @override
  Widget build(BuildContext context) {
    return StyledScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Builder(
          builder: (context) {
            final addons = context.watch<AddOnProvider>().value;

            return AddonInjectorWidget(
              addons: addons,
              routerData: routerData,
              child: TrippleSplitView(
                isLeftDisabled: disableNavigation,
                isRightDisabled: disableProperties,
                leftChild: NavigationPanelWrapper(
                  initialPath: routerData['path'] as String?,
                ),
                centerChild: const Workbench(),
                rightChild: const SettingsPanel(),
              ),
            );
          },
        ),
      ),
    );
  }
}
