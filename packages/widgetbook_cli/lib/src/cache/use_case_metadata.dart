import 'cache_exception.dart';

typedef KnobsConfigs = Map<String, Map<String, dynamic>>;

class UseCaseMetadata {
  const UseCaseMetadata({
    required this.name,
    required this.useCaseName,
    required this.componentName,
    required this.importStatement,
    required this.componentImportStatement,
    required this.navPath,
    required this.cloudExclude,
    this.designLink,
    this.knobsConfigs,
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

  // Import statement of the component
  final String componentImportStatement;

  // Path to the element in Widgetbook
  // This might be null if users are using widgetbook_generator <= 3.2.0
  final String? navPath;

  // Whether to exclude this use-case from the cloud.
  final bool cloudExclude;

  // A link to a component or variant
  final String? designLink;

  final KnobsConfigs? knobsConfigs;

  // ignore: sort_constructors_first
  factory UseCaseMetadata.fromJson(Map<String, dynamic> map) {
    try {
      return UseCaseMetadata(
        name: map['name'] as String,
        useCaseName: map['useCaseName'] as String,
        componentName: map['componentName'] as String,
        importStatement: map['importStatement'] as String,
        componentImportStatement: map['componentImportStatement'] as String,
        navPath: map['navPath'] as String?,
        // This might be null if users are using widgetbook_generator <= 3.13.0
        cloudExclude: map['cloudExclude'] as bool? ?? false,
        designLink: map['designLink'] as String?,
        knobsConfigs: map['knobsConfigs'] != null
            ? Map<String, Map<String, dynamic>>.from(
                map['knobsConfigs'] as Map,
              )
            : null,
      );
    } catch (e) {
      throw CacheFormatException('use-case', map, e);
    }
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
      'knobsConfigs': knobsConfigs,
    };
  }
}
