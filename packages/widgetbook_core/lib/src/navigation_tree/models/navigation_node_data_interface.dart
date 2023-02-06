import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

@immutable
abstract class NavigationNodeDataInterface {
  const NavigationNodeDataInterface({
    required this.name,
    required this.type,
    this.data,
    this.children = const [],
    this.isInitiallyExpanded = true,
  });

  final String name;
  final NavigationNodeType type;
  final dynamic data;
  final List<NavigationNodeDataInterface> children;
  final bool isInitiallyExpanded;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is NavigationNodeDataInterface &&
        other.name == name &&
        other.type == type &&
        other.data == data &&
        listEquals(other.children, children) &&
        other.isInitiallyExpanded == other.isInitiallyExpanded;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      type.hashCode ^
      data.hashCode ^
      isInitiallyExpanded.hashCode ^
      children.hashCode;
}
