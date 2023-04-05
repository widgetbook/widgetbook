import 'package:flutter/material.dart';
import 'package:widgetbook_core/src/settings/widgets/widgets.dart';

class Setting extends StatelessWidget {
  const Setting({
    required this.name,
    required this.child,
    super.key,
    this.trailing,
  });

  final String name;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 12,
          ),
          SettingHeader(
            content: name,
            trailing: trailing,
          ),
          const SizedBox(
            height: 12,
          ),
          child,
        ],
      ),
    );
  }
}
