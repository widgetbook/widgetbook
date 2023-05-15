enum WidgetbookPanel {
  navigation,
  addons,
  knobs,
}

extension WidgetbookPanelParser on WidgetbookPanel {
  static Set<WidgetbookPanel> parse(String value) {
    if (value.isEmpty || value == '{}') {
      return {};
    }

    return value
        .replaceAll(RegExp('[{}]'), '')
        .split(',')
        .map((name) => WidgetbookPanel.values.byName(name))
        .toSet();
  }
}
