class VersionsMetadata {
  VersionsMetadata({
    required this.flutter,
    required this.widgetbook,
    required this.cli,
    required this.generator,
    required this.annotation,
  });

  final String? flutter;
  final String? widgetbook;
  final String cli;
  final String? generator;
  final String? annotation;

  Map<String, String> toHeaders() {
    return {
      'x-widgetbook_cli-version': cli,
      if (flutter != null) 'x-flutter-version': flutter!,
      if (widgetbook != null) 'x-widgetbook-version': widgetbook!,
      if (generator != null) 'x-widgetbook_generator-version': generator!,
      if (annotation != null) 'x-widgetbook_annotation-version': annotation!,
    };
  }
}
