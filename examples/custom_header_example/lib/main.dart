import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const WidgetbookApp());
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: [
        WidgetbookComponent(
          name: 'Example Component',
          useCases: [
            WidgetbookUseCase(
              name: 'Default',
              builder: (context) => const Center(
                child: Text('Example Component'),
              ),
            ),
          ],
        ),
      ],
      // Custom header for branding and description
      header: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FlutterLogo(size: 40),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'My Design System',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'A collection of reusable components for our app',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
