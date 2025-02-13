class UseCaseMetadata {
  const UseCaseMetadata({
    required this.name,
    required this.useCaseName,
    required this.componentName,
    required this.importStatement,
    required this.navPath,
    required this.componentImportStatement,
    this.designLink,
  });

  // Name of the builder function defining the use-case
  final String name;

  // Name of the use-case, e.g. 'Default'
  final String useCaseName;

  // Name of the use-case, e.g. 'ElevatedButton'
  // This will be extracted from the type
  final String componentName;

  // Import statement of the use-case definition
  final String importStatement;

  // Path to the element in Widgetbook
  // This might be null if users are using widgetbook_generator <= 3.2.0
  final String? navPath;

  // Import statement of the component
  final String componentImportStatement;

  // A link to a component or variant
  final String? designLink;

  // ignore: sort_constructors_first
  factory UseCaseMetadata.fromJson(Map<String, dynamic> map) {
    return UseCaseMetadata(
      name: map['name'] as String,
      useCaseName: map['useCaseName'] as String,
      componentName: map['componentName'] as String,
      importStatement: map['importStatement'] as String,
      navPath: map['navPath'] as String?,
      componentImportStatement: map['componentImportStatement'] as String,
      designLink:
          map['designLink'] != null ? map['designLink'] as String : null,
    );
  }

  Map<String, dynamic> toCloudUseCase() {
    // Not all properties are needed by the Cloud, so we only serialize the
    // required ones. This insures that the payload size is as small as possible
    // when there are many use-cases.
    return {
      'name': useCaseName,
      'componentName': componentName,
      'navPath': navPath,
      'designLink': designLink,
    };
  }
}
