import 'package:flutter/material.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: SearchField)
Widget searchFieldDefaultUseCase(BuildContext context) {
  return const SearchField();
}
