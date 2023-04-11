abstract class WidgetbookAddOnModel {
  const WidgetbookAddOnModel();

  /// Required to allow proper deep linking including AddOn property selection
  ///
  /// Defaults to an empty Map, which means no query parameters are set for the
  /// route
  Map<String, String> toQueryParameter() {
    return {};
  }
}
