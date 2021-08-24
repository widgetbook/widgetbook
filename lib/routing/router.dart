import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook/cubit/canvas/canvas_cubit.dart';
import 'package:widgetbook/cubit/organizer/organizer_cubit.dart';
import 'package:widgetbook/models/app_info.dart';
import 'package:widgetbook/navigation/navigation.dart';
import 'package:widgetbook/widgets/wrapper.dart';
import 'package:widgetbook/models/organizers/organizers.dart' as models;

ModalRoute<void> generateRoute(
  BuildContext context,
  AppInfo appInfo,
  String? name, {
  RouteSettings? settings,
}) {
  var stories = recursiveRetrievalOfStates(
    context.read<OrganizerCubit>().state.allCategories,
  );
  var selectedStory = selectStoryFromPath(name, stories);
  context.read<CanvasCubit>().selectStory(selectedStory);

  return StoryRoute(
    settings: settings,
    builder: (context) {
      return Builder(
        builder: (context) => Row(
          children: [
            BlocBuilder<OrganizerCubit, OrganizerState>(
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
      // TODO
      // states.addAll(recursiveRetrievalOfStates(current.organizers));
    }
  }
  return states;
}
