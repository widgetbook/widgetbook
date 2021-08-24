import 'package:flutter/material.dart';
import 'package:widgetbook/models/organizers/organizers.dart';
import 'package:widgetbook/navigation/ui/tiles/tile_helper_methods.dart';
import '../../../utils/utils.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  const CategoryTile({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Text(
            category.name,
            style: context.textTheme.subtitle2!,
          ),
        ),
        ...buildFolders(
          folders: category.folders,
          currentLevel: 0,
        ),
        ...buildWidgets(
          widgets: category.widgets,
          currentLevel: 0,
        ),
      ],
    );
  }
}
