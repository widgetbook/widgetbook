import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/src/knobs/knobs_builder.dart';
import 'package:widgetbook/src/navigation.dart/navigation_panel.dart';
import 'package:widgetbook/src/navigation.dart/organizer_provider.dart';
import 'package:widgetbook/src/navigation.dart/preview_provider.dart';
import 'package:widgetbook/src/navigation.dart/preview_state.dart';
import 'package:widgetbook/src/routing/story_route_path.dart';
import 'package:widgetbook/src/styled_widgets/styled_scaffold.dart';
import 'package:widgetbook/src/workbench/workbench.dart';
import 'package:widgetbook/widgetbook.dart';

import '../constants/radii.dart';

class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  @override
  Iterable<RouteTransitionRecord> resolve({
    required List<RouteTransitionRecord> newPageRouteHistory,
    required Map<RouteTransitionRecord?, RouteTransitionRecord>
        locationToExitingPageRoute,
    required Map<RouteTransitionRecord?, List<RouteTransitionRecord>>
        pageRouteToPagelessRoutes,
  }) {
    final results = <RouteTransitionRecord>[];

    for (final pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
        pageRoute.markForAdd();
      }
      results.add(pageRoute);
    }
    for (final exitingPageRoute in locationToExitingPageRoute.values) {
      if (exitingPageRoute.isWaitingForExitingDecision) {
        exitingPageRoute.markForRemove();
        final pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute];
        if (pagelessRoutes != null) {
          for (final pagelessRoute in pagelessRoutes) {
            pagelessRoute.markForRemove();
          }
        }
      }
      results.add(exitingPageRoute);
    }
    return results;
  }
}

class StoryRouterDelegate<CustomTheme> extends RouterDelegate<StoryRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<StoryRoutePath> {
  StoryRouterDelegate({
    required this.appInfo,
    required this.previewState,
  }) : navigatorKey = GlobalKey<NavigatorState>();

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppInfo appInfo;
  final PreviewState previewState;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      transitionDelegate: NoAnimationTransitionDelegate(),
      pages: [
        MaterialPage<dynamic>(
          key: ValueKey(currentConfiguration.path),
          child: StyledScaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Builder(builder: (context) {
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
                      child: Column(
                        children: [
                          Expanded(child: Workbench<CustomTheme>()),
                          const SizedBox(
                            width: 1000,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Container(
                              width: double.infinity,
                              height: 300,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: Radii.defaultRadius,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Knobs',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    ...context
                                        .watch<KnobsNotifier>()
                                        .all()
                                        .map((e) => e.build())
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        )
      ],
      onPopPage: (route, dynamic result) {
        if (!route.didPop(result)) {
          return false;
        }

        context.read<PreviewProvider>().deselectStory();
        notifyListeners();

        return true;
      },
    );
  }

  @override
  StoryRoutePath get currentConfiguration => StoryRoutePath(
        path: previewState.selectedUseCase == null
            ? '/'
            : '/stories/${previewState.selectedUseCase!.path}',
      );

  @override
  Future<void> setNewRoutePath(StoryRoutePath configuration) async {}
}
