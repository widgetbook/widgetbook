import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class NavigationBlocProvider extends StatelessWidget {
  const NavigationBlocProvider({
    super.key,
    required this.child,
    required this.directories,
  });

  final Widget child;
  final List<MultiChildNavigationNodeData> directories;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc()
        ..add(
          LoadNavigationTree(directories: directories),
        ),
      child: child,
    );
  }
}
