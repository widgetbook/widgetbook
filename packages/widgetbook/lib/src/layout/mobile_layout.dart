import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';

import '../settings/settings.dart';
import '../state/state.dart';
import 'base_layout.dart';

class MobileLayout extends StatefulWidget implements BaseLayout {
  const MobileLayout({
    super.key,
    required this.navigationBuilder,
    required this.addonsBuilder,
    required this.knobsBuilder,
    required this.argsBuilder,
    required this.workbench,
  });

  final Widget Function(BuildContext context) navigationBuilder;
  final List<Widget> Function(BuildContext context) addonsBuilder;
  final List<Widget> Function(BuildContext context) knobsBuilder;
  final List<Widget> Function(BuildContext context) argsBuilder;
  final Widget workbench;

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(interceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(interceptor);
    super.dispose();
  }

  Future<bool> interceptor(bool stopDefaultButtonEvent, RouteInfo info) async {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
      return true;
    } else {
      final exitApp = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Exit'),
            content: const Text('Do you want to exit app?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('NO'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('YES'),
              ),
            ],
          );
        },
      );
      return exitApp != true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);

    return Scaffold(
      key: ValueKey(state.isNext), // Rebuild when switching to next
      body: SafeArea(
        child: widget.workbench,
      ),
      bottomNavigationBar: ExcludeSemantics(
        child: BottomNavigationBar(
          items: [
            const BottomNavigationBarItem(
              label: 'Navigation',
              icon: Icon(Icons.list_outlined),
            ),
            const BottomNavigationBarItem(
              label: 'Addons',
              icon: Icon(Icons.dashboard_customize_outlined),
            ),
            BottomNavigationBarItem(
              label: state.isNext ? 'Args' : 'Knobs',
              icon: const Icon(Icons.tune_outlined),
            ),
          ],
          onTap: (index) {
            showModalBottomSheet<void>(
              context: context,
              builder: (context) {
                switch (index) {
                  case 0:
                    return ExcludeSemantics(
                      child: widget.navigationBuilder(context),
                    );
                  case 1:
                    return ExcludeSemantics(
                      child: MobileSettingsPanel(
                        name: 'Addons',
                        builder: widget.addonsBuilder,
                      ),
                    );
                  case 2:
                    return ExcludeSemantics(
                      child: state.isNext
                          ? MobileSettingsPanel(
                              name: 'Args',
                              builder: widget.argsBuilder,
                            )
                          : MobileSettingsPanel(
                              name: 'Knobs',
                              builder: widget.knobsBuilder,
                            ),
                    );
                  default:
                    return Container();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
