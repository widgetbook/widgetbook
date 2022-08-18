import 'package:flutter/widgets.dart';

class WidgetbookAddOn {
  const WidgetbookAddOn({
    required this.icon,
    required this.name,
    // TODO This can be optional/nullable
    required this.wrapperBuilder,
    required this.builder,
    required this.previewBuilder,
  });

  // TODO if we make this a builder, we can access buildcontext
  final Widget icon;
  final String name;
  final Widget Function(BuildContext context, Widget child) wrapperBuilder;
  final Widget Function(BuildContext context) builder;
  final Widget Function(BuildContext context, Widget child) previewBuilder;
}
