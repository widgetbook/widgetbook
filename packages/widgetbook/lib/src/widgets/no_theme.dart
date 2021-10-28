import 'package:flutter/material.dart';
import 'package:widgetbook/src/utils/extensions.dart';

class NoTheme extends StatelessWidget {
  const NoTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Tooltip(
        message: 'Make sure to inject a theme into Widgetbook.',
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.dark_mode,
              color: context.theme.hintColor,
              size: 40,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              'No theme defined',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
