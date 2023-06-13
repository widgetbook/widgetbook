import 'package:flutter/material.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'navigation_test_data.dart';

@UseCase(name: 'Default', type: NavigationTree)
Widget navigationTreeDefaultUseCase(BuildContext context) {
  return const NavigationTree(
    directories: directories,
    searchQuery: '',
  );
}
