import 'package:flutter/material.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: StatsBanner)
Widget searchFieldDefaultUseCase(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: StatsBanner(
        componentsCount: context.knobs.int.slider(label: 'Components Count'),
        useCasesCount: context.knobs.int.slider(label: 'Use-cases Count'),
      ),
    ),
  );
}
