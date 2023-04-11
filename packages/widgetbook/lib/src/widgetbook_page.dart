import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';
import 'package:widgetbook/src/routing/widgetbook_panel.dart';
import 'package:widgetbook/src/settings_panel/settings_panel.dart';
import 'package:widgetbook/src/styled_widgets/styled_scaffold.dart';
import 'package:widgetbook/src/workbench/workbench.dart';

class WidgetbookPage extends StatelessWidget {
  const WidgetbookPage({
    required this.activePanels,
    required this.routerData,
    super.key,
  });

  final Set<WidgetbookPanel> activePanels;
  final Map<String, String> routerData;

  @override
  Widget build(BuildContext context) {
    return StyledScaffold(
      body: Builder(
        builder: (context) {
          final addons = context.watch<AddOnProvider>().value;
          final enableSettings = activePanels.contains(
                WidgetbookPanel.addons,
              ) ||
              activePanels.contains(
                WidgetbookPanel.knobs,
              );

          return AddonInjectorWidget(
            addons: addons,
            routerData: routerData,
            child: Row(
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Workbench(),
                  ),
                ),
                if (enableSettings)
                  SizedBox(
                    width: 400,
                    child: SettingsPanel(
                      activePanels: activePanels,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
