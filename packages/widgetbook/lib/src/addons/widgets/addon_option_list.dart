import 'package:flutter/material.dart';
import 'package:widgetbook/src/addons/widgets/addon_option.dart';
import 'package:widgetbook/src/addons/widgets/addon_option_spacing.dart';

class AddonOptionList<T> extends StatelessWidget {
  const AddonOptionList({
    super.key,
    required this.name,
    required this.options,
    required this.selectedOption,
    required this.onTap,
    required this.builder,
  });

  final String name;
  final List<T> options;
  final T selectedOption;
  final void Function(T item) onTap;
  final Widget Function(T item) builder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = options[index];
              return AddonOption(
                isSelected: selectedOption == item,
                onTap: () {
                  onTap(item);
                },
                child: builder(item),
              );
            },
            separatorBuilder: (_, __) {
              return const AddonOptionSpacing();
            },
            itemCount: options.length,
          ),
        ],
      ),
    );
  }
}
