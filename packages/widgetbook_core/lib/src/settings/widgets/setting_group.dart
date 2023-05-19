import 'package:flutter/material.dart';

class SettingGroup extends StatelessWidget {
  const SettingGroup({
    super.key,
    required this.settings,
  });

  final List<Widget> settings;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return settings[index];
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 1,
        );
      },
      itemCount: settings.length,
    );
  }
}
