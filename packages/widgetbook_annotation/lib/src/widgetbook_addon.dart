/// An annotation to configure the Addons used within Widgetbook
class WidgetbookAddonAnnotation<T> {
  /// Creates a new instance of [WidgetbookAddonAnnotation]
  const WidgetbookAddonAnnotation({
    required this.setting,
  });

  /// The setting that defines available as well as selected values.
  final T setting;
}
