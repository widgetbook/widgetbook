import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook/src/cubit/canvas/canvas_cubit.dart';
import 'package:widgetbook/src/cubit/categories/categories_cubit.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/src/routing/story_route_path.dart';
import 'package:widgetbook/src/styled_widgets/styled_scaffold.dart';
import 'package:widgetbook/src/widgets/wrapper.dart';

import '../../widgetbook.dart';

class StoryRouterDelegate extends RouterDelegate<StoryRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<StoryRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  final AppInfo appInfo;
  final CanvasState canvasState;

  StoryRouterDelegate({
    required this.appInfo,
    required this.canvasState,
  }) : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage(
          key: ValueKey(currentConfiguration.path),
          child: StyledScaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) => Row(
                  children: [
                    BlocBuilder<CategoriesCubit, OrganizerState>(
                      builder: (context, state) {
                        return NavigationPanel(
                          appInfo: appInfo,
                          categories: state.filteredCategories,
                        );
                      },
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Editor(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        context.read<CanvasCubit>().deselectStory();
        notifyListeners();

        return true;
      },
    );
  }

  @override
  StoryRoutePath get currentConfiguration => StoryRoutePath(
        path: canvasState.selectedStory == null
            ? '/'
            : '/stories/${canvasState.selectedStory!.path}',
      );

  @override
  Future<void> setNewRoutePath(StoryRoutePath path) async {}
}
