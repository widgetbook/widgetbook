import 'package:flutter/material.dart';

/// A [StatefulWidget] that builds the content of a settings panel and keeps it alive when it's not visible.
class SettingsPanelBuilder extends StatefulWidget {
  /// Creates a [SettingsPanelBuilder] with the specified configuration.
  const SettingsPanelBuilder({required this.builder, super.key});

  /// A builder function that creates the widget to be rendered in the settings side panel.
  final Widget Function(BuildContext) builder;

  @override
  State<SettingsPanelBuilder> createState() => _SettingsPanelBuilderState();
}

class _SettingsPanelBuilderState extends State<SettingsPanelBuilder>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.builder(context);
  }

  @override
  bool get wantKeepAlive => true;
}
