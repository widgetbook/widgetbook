import 'package:flutter/material.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class SettingSection extends StatelessWidget {
  const SettingSection({
    super.key,
    required this.data,
  });

  final SettingSectionData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            data.name,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return data.settings[index];
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 2,
              );
            },
            itemCount: data.settings.length,
          ),
        ],
      ),
    );
  }
}
