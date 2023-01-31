import 'package:flutter/material.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class ComplexSetting extends StatelessWidget {
  const ComplexSetting({
    super.key,
    required this.name,
    required this.setting,
    this.sections = const [],
  });

  final String name;
  final List<SettingSectionData> sections;
  final Widget setting;

  @override
  Widget build(BuildContext context) {
    return Setting(
      name: name,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          setting,
          if (sections.isNotEmpty)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return SettingSection(data: sections[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 2,
                );
              },
              itemCount: sections.length,
            ),
        ],
      ),
    );
  }
}
