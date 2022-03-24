import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/app_info/app_info_provider.dart';
import 'package:widgetbook/src/navigation.dart/navigation_panel.dart';
import 'package:widgetbook/src/navigation.dart/organizer_provider.dart';
import 'package:widgetbook/src/styled_widgets/styled_scaffold.dart';
import 'package:widgetbook/src/workbench/workbench.dart';

class WidgetbookPage<CustomTheme> extends StatelessWidget {
  const WidgetbookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StyledScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Builder(builder: (context) {
          final appInfo = context.watch<AppInfoProvider>().state;
          final state = context.watch<OrganizerProvider>().state;
          return Row(
            children: [
              NavigationPanel(
                appInfo: appInfo,
                categories: state.filteredCategories,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Workbench<CustomTheme>(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
