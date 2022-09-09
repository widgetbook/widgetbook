import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';

class Renderer extends StatelessWidget {
  const Renderer({
    super.key,
    required this.useCaseBuilder,
    required this.appBuilder,
  });

  final Widget Function(BuildContext) useCaseBuilder;
  final Widget Function(BuildContext, Widget child) appBuilder;

  Widget _buildPreview(
    BuildContext context, {
    required List<WidgetbookAddOn> addons,
    WidgetbookAddOn? multiPropertyAddon,
    required int index,
  }) {
    return MultiProvider(
      providers: [
        if (multiPropertyAddon != null)
          multiPropertyAddon.providerBuilder(context, index),
        ...addons
            .where((element) => element != multiPropertyAddon)
            .map((e) => e.providerBuilder(context, 0))
            .toList(),
      ],
      child: Builder(
        builder: (context) {
          return appBuilder(
            context,
            Builder(
              builder: useCaseBuilder,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final addons = context.watch<AddOnProvider>().value;
    final multiPropertyAddons =
        addons.where((addon) => addon.selectionCount(context) > 1).toList();
    final multiPropertyAddon =
        multiPropertyAddons.isNotEmpty ? multiPropertyAddons.first : null;

    if (multiPropertyAddon == null) {
      return _buildPreview(
        context,
        addons: addons,
        index: 0,
      );
    } else {
      final renders = Iterable.generate(
        multiPropertyAddon.selectionCount(context),
        (value) => Padding(
          padding: const EdgeInsets.all(8),
          child: _buildPreview(
            context,
            addons: addons,
            multiPropertyAddon: multiPropertyAddon,
            index: value,
          ),
        ),
      ).toList();
      return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: renders.length,
        itemBuilder: (context, index) {
          final item = renders.elementAt(index);
          return item;
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 8,
          height: 8,
        ),
      );
    }
  }
}
