abstract class WidgetbookAddOnModel<T> {
  const WidgetbookAddOnModel();

  /// Required to allow proper deep linking including AddOn property selection
  ///
  /// Defaults to an empty Map, which means no query parameters are set for the
  /// route
  Map<String, String> toQueryParameter() {
    return {};
  }

  /// Allows for parsing of [queryParameters] by using information from the
  /// router and from the initially provided [WidgetbookAddOnModel].
  ///
  /// If no [queryParameters] are available, return `null`.
  /// If [queryParameters] are available return a property `Setting` object.
  ///
  /// If not overridden, returns `null`.
  T? fromQueryParameter(
    Map<String, String> queryParameters,
  ) {
    return null;
  }
}
