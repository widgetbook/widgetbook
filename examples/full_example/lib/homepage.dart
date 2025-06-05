import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Homepage'),
          ElevatedButton(
            onPressed: () {
              WidgetbookState.of(context).open('widgets/containers/component');
            },
            child: const Text('Go to Container'),
          ),
        ],
      ),
    );
  }
}
