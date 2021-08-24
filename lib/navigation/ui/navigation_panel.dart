import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/models/app_info.dart';
import 'package:widgetbook/models/organizers/organizers.dart';
import 'package:widgetbook/navigation/ui/tiles/category_tile.dart';
import 'package:widgetbook/widgets/header.dart';

class NavigationPanel extends StatefulWidget {
  const NavigationPanel({
    Key? key,
    required this.appInfo,
    required this.categories,
  }) : super(key: key);

  final AppInfo appInfo;
  final List<Category> categories;

  @override
  _NavigationPanelState createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  final ScrollController controller = ScrollController();
  Story? selectedComponent;

  final TextEditingController search = TextEditingController();
  String query = '';

  Widget _buildCategory(BuildContext context, int i) {
    final Category item = widget.categories[i];
    return CategoryTile(category: item);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 50, maxWidth: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            appInfo: widget.appInfo,
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              padding: EdgeInsets.all(16),
              child: Builder(
                builder: (context) {
                  return ListView.separated(
                    controller: controller,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: widget.categories.length,
                    itemBuilder: _buildCategory,
                    padding: const EdgeInsets.only(bottom: 8),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
