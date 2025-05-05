# Custom Header Example

This example demonstrates how to use the custom header feature in Widgetbook to add branding and description to the sidebar.

## Usage

To add a custom header to your Widgetbook, simply provide a `customHeader` parameter to the Widgetbook constructor:

```dart
Widgetbook.material(
  directories: [
    // Add your directories here
  ],
  customHeader: Column(
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
```

The custom header will appear at the top of the navigation panel, above the search field.

## Result

The custom header provides a way to add branding and context to your Widgetbook, making it more personalized and informative for your team.
