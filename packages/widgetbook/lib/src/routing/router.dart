import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook/src/cubit/canvas/canvas_cubit.dart';
import 'package:widgetbook/src/cubit/categories/categories_cubit.dart';
import 'package:widgetbook/src/models/app_info.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/src/widgets/wrapper.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart' as models;

ModalRoute<void> generateRoute(
  BuildContext context,
  AppInfo appInfo,
  String? name, {
  RouteSettings? settings,
}) {
  var stories = recursiveRetrievalOfStates(
    context.read<CategoriesCubit>().state.allCategories,
  );
  var selectedStory = selectStoryFromPath(name, stories);
  context.read<CanvasCubit>().selectStory(selectedStory);

  return StoryRoute(
    settings: settings,
    builder: (context) {
      return Builder(
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
            Expanded(child: Editor()),
          ],
        ),
      );
    },
  );
}

class StoryRoute extends PopupRoute<void> {
  StoryRoute({
    required this.builder,
    RouteSettings? settings,
  }) : super(settings: settings);

  final WidgetBuilder builder;

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) =>
      builder(context);

  @override
  Duration get transitionDuration => const Duration();
}

models.Story? selectStoryFromPath(String? path, List<models.Story> stories) {
  final storyPath = path?.replaceFirst('/stories/', '') ?? '';
  models.Story? story;
  for (final element in stories) {
    if (element.path == storyPath) story = element;
  }
  return story;
}

List<models.Story> recursiveRetrievalOfStates(
  List<models.Organizer> organizers,
) {
  final List<models.Story> states = [];
  for (final models.Organizer current in organizers) {
    if (current is models.WidgetElement) {
      states.addAll(current.stories);
    } else {
      // TODO this need to be fixed
      // states.addAll(recursiveRetrievalOfStates(current.organizers));
    }
  }
  return states;
}
