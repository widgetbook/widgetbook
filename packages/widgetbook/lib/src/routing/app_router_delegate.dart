import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../state/state.dart';
import '../workbench/workbench.dart';
import 'app_route_config.dart';
import 'widgetbook_shell.dart';

@internal
class AppRouterDelegate extends RouterDelegate<AppRouteConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRouteConfig> {
  AppRouterDelegate({
    this.initialRoute = '/',
    required this.state,
  })  : _navigatorKey = GlobalKey<NavigatorState>(),
        _configuration = AppRouteConfig(
          uri: Uri.parse(initialRoute),
        );

  final String initialRoute;
  final WidgetbookState state;
  final GlobalKey<NavigatorState> _navigatorKey;
  AppRouteConfig _configuration;

  @override
  AppRouteConfig? get currentConfiguration => _configuration;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(AppRouteConfig configuration) async {
    _configuration = configuration;
    state.updateFromRouteConfig(configuration);
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: (route, result) => route.didPop(result),
      pages: [
        MaterialPage(
          child: _configuration.previewMode
              ? const Workbench()
              : MainApp(
                  key: ValueKey(_configuration),
                ),
        ),
      ],
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  bool showLeftPanel = true;
  bool showRightPanel = true;

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.keyN): const ToggleLeftPanelIntent(),
        LogicalKeySet(LogicalKeyboardKey.keyM): const ToggleRightPanelIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          ToggleLeftPanelIntent: CallbackAction<ToggleLeftPanelIntent>(
            onInvoke: (intent) => setState(() {
              showLeftPanel = !showLeftPanel;
            }),
          ),
          ToggleRightPanelIntent: CallbackAction<ToggleRightPanelIntent>(
            onInvoke: (intent) => setState(() {
              showRightPanel = !showRightPanel;
            }),
          ),
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                setState(() {
                  showLeftPanel = !showLeftPanel;
                });
              },
            ),
            title: const Text('Widgetbook'),
            actions: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  setState(() {
                    showRightPanel = !showRightPanel;
                  });
                },
              ),
            ],
          ),
          body: WidgetbookShell(
            key: widget.key,
            showLeftPanel: showLeftPanel,
            showRightPanel: showRightPanel,
            child: const Workbench(),
          ),
        ),
      ),
    );
  }
}

class ToggleLeftPanelIntent extends Intent {
  const ToggleLeftPanelIntent();
}

class ToggleRightPanelIntent extends Intent {
  const ToggleRightPanelIntent();
}
