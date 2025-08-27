/// Creates and configures an MCP server that provides programmatic access to Widgetbook
/// functionality. This enables external tools like IDEs and AI assistants to interact
/// with Widgetbook instances through standardized tooling protocols.
import 'dart:convert';

import 'package:mcp_dart/mcp_dart.dart';

import '../../../widgetbook.dart';

/// Factory function that creates a fully configured MCP server bound to a specific
/// Widgetbook state instance. The server exposes tools for navigation, inspection,
/// and manipulation of Widgetbook components and their configurations.
McpServer getServer(WidgetbookState state) {
  final server = McpServer(
    const Implementation(
      name: 'widgetbook-mcp-server',
      version: '1.0.0',
    ),
  );

  // Screenshot capture tool - enables visual testing and documentation workflows
  server.tool(
    'get_screenshot',
    description:
        'A tool for obtaining a screenshot from the currently selected Widgetbook use case. The correct use case must be selected before calling this tool.',
    callback: ({args, extra}) async {
      final screenshotAddon =
          state.addons?.firstWhere(
                (addon) => addon is McpAddon,
              )
              as McpAddon;

      final screenshot = await screenshotAddon.captureScreenshot();

      return CallToolResult.fromContent(
        content:
            screenshot == null
                ? [
                  const TextContent(
                    text:
                        'No screenshot available. Make sure a use case is selected.',
                  ),
                ]
                : [
                  ImageContent(
                    data: screenshot,
                    mimeType: 'image/png',
                  ),
                ],
      );
    },
  );

  // Render tree inspection tool - provides detailed widget hierarchy for debugging
  server.tool(
    'get_render_tree',
    description:
        'A tool for obtaining the render tree structure from the currently selected Widgetbook use case in JSON format. The correct use case must be selected before calling this tool.',
    callback: ({args, extra}) async {
      final mcpAddon =
          state.addons?.firstWhere(
                (addon) => addon is McpAddon,
              )
              as McpAddon;

      final renderTree = await mcpAddon.captureRenderTreeAsJson();

      if (renderTree == null) {
        return CallToolResult.fromContent(
          content: [
            const TextContent(
              text:
                  'Failed to capture render tree. Make sure a use case is selected.',
            ),
          ],
        );
      }

      return CallToolResult.fromContent(
        content: [
          TextContent(
            text: renderTree,
          ),
        ],
      );
    },
  );

  // Navigation search tool - intelligent search for use cases with pattern support
  server.tool(
    'search_use_cases',
    description:
        'A tool for searching Widgetbook use cases by pattern. Supports glob patterns like "button*", "*input*", "forms/**". Use this instead of listing all use cases to avoid context bloat. Returns matching use cases with their paths, names, and component information.',
    toolInputSchema: const ToolInputSchema(
      properties: {
        'pattern': {
          'type': 'string',
          'description':
              'Search pattern. Supports glob patterns like "button*" (starts with), "*input*" (contains), "forms/**" (in folder), or plain text search',
        },
        'limit': {
          'type': 'integer',
          'description':
              'Maximum number of results to return (default: 20, max: 100)',
        },
      },
      required: ['pattern'],
    ),
    callback: ({args, extra}) async {
      final pattern = args?['pattern'] as String?;
      final limit = (args?['limit'] as int?) ?? 20;

      if (pattern == null || pattern.isEmpty) {
        return CallToolResult.fromContent(
          content: [const TextContent(text: 'Pattern is required')],
        );
      }

      final results = _searchUseCases(state, pattern, limit);
      return CallToolResult.fromContent(
        content: [
          TextContent(
            text: jsonEncode(results),
          ),
        ],
      );
    },
  );

  // Use case count tool - get overview without listing all cases
  server.tool(
    'get_use_case_count',
    description:
        'A tool for getting the total count of use cases and components in the Widgetbook without listing them all. Use this for overview information.',
    callback: ({args, extra}) async {
      final root = state.root;
      final counts = {
        'totalUseCases': root.useCasesCount,
        'totalComponents': root.componentsCount,
        'summary':
            'Found ${root.useCasesCount} use cases across ${root.componentsCount} components',
      };

      return CallToolResult.fromContent(
        content: [
          TextContent(
            text: jsonEncode(counts),
          ),
        ],
      );
    },
  );

  // Navigation discovery tool - minimal structure view for large projects
  server.tool(
    'list_use_cases',
    description:
        'A tool for obtaining the Widgetbook structure. WARNING: For large projects, this returns extensive data that can bloat context. Prefer using search_use_cases with patterns or get_use_case_count for overview.',
    toolInputSchema: const ToolInputSchema(
      properties: {
        'structure_only': {
          'type': 'boolean',
          'description':
              'If true, returns only folder/component structure without use case details (default: false)',
        },
        'max_depth': {
          'type': 'integer',
          'description': 'Maximum depth to traverse (default: unlimited)',
        },
      },
      required: [],
    ),
    callback: ({args, extra}) async {
      final structureOnly = (args?['structure_only'] as bool?) ?? false;
      final maxDepth = args?['max_depth'] as int?;

      final directories = state.directories;
      final directoriesJson = _convertDirectoriesToJson(
        directories,
        structureOnly: structureOnly,
        maxDepth: maxDepth,
      );

      return CallToolResult.fromContent(
        content: [
          TextContent(
            text: directoriesJson,
          ),
        ],
      );
    },
  );

  // Navigation control tool - programmatically switch between use cases
  server.tool(
    'select_use_case',
    description:
        'A tool for selecting a use case in the Widgetbook. Must be used before calling the get_screenshot tool.',
    toolInputSchema: const ToolInputSchema(
      properties: {
        'path': {
          'type': 'string',
          'description': 'The path to the use case that is activated',
        },
      },
      required: ['path'],
    ),
    callback: ({args, extra}) async {
      final path = args?['path'] as String?;

      if (path == null) {
        return CallToolResult.fromContent(
          content: [const TextContent(text: 'No path provided')],
        );
      }

      state.updatePath(path);

      return CallToolResult.fromContent(
        content: [const TextContent(text: 'Path successfully updated')],
      );
    },
  );

  // Addon introspection tool - discovers available configuration options
  server.tool(
    'list_addons',
    description:
        'A tool for obtaining information about all available addons in the Widgetbook, including their names, descriptions, field configurations, and other properties.',
    callback: ({args, extra}) async {
      final addons = state.addons;
      final addonsJson = _convertAddonsToJson(addons);

      return CallToolResult.fromContent(
        content: [
          TextContent(
            text: addonsJson,
          ),
        ],
      );
    },
  );

  // Addon configuration tool - modifies runtime addon settings
  server.tool(
    'update_addon_field',
    description:
        'A tool for updating the value of a specific field in a Widgetbook addon. Use this to change addon configurations like theme, viewport, or other settings.',
    toolInputSchema: const ToolInputSchema(
      properties: {
        'addonName': {
          'type': 'string',
          'description':
              'The name of the addon to update (e.g., "Theme", "Viewport")',
        },
        'fieldName': {
          'type': 'string',
          'description': 'The name of the field within the addon to update',
        },
        'value': {
          'type': 'string',
          'description':
              'The new value for the field (will be parsed according to field type)',
        },
      },
      required: ['addonName', 'fieldName', 'value'],
    ),
    callback: ({args, extra}) async {
      final addonName = args?['addonName'] as String?;
      final fieldName = args?['fieldName'] as String?;
      final value = args?['value'] as String?;

      if (addonName == null || fieldName == null || value == null) {
        return CallToolResult.fromContent(
          content: [
            const TextContent(
              text:
                  'Missing required parameters: addonName, fieldName, and value are required',
            ),
          ],
        );
      }

      try {
        final result = _updateAddonField(state, addonName, fieldName, value);
        return CallToolResult.fromContent(
          content: [TextContent(text: result)],
        );
      } catch (e) {
        return CallToolResult.fromContent(
          content: [TextContent(text: 'Error updating addon field: $e')],
        );
      }
    },
  );

  // Addon state inspection tool - reads current addon configuration values
  server.tool(
    'get_addon_field_value',
    description:
        'A tool for retrieving the current value of a specific field in a Widgetbook addon. Use this to check current addon configurations.',
    toolInputSchema: const ToolInputSchema(
      properties: {
        'addonName': {
          'type': 'string',
          'description':
              'The name of the addon to query (e.g., "Theme", "Viewport")',
        },
        'fieldName': {
          'type': 'string',
          'description': 'The name of the field within the addon to retrieve',
        },
      },
      required: ['addonName', 'fieldName'],
    ),
    callback: ({args, extra}) async {
      final addonName = args?['addonName'] as String?;
      final fieldName = args?['fieldName'] as String?;

      if (addonName == null || fieldName == null) {
        return CallToolResult.fromContent(
          content: [
            const TextContent(
              text:
                  'Missing required parameters: addonName and fieldName are required',
            ),
          ],
        );
      }

      try {
        final result = _getAddonFieldValue(state, addonName, fieldName);
        return CallToolResult.fromContent(
          content: [TextContent(text: result)],
        );
      } catch (e) {
        return CallToolResult.fromContent(
          content: [
            TextContent(text: 'Error retrieving addon field value: $e'),
          ],
        );
      }
    },
  );

  // Knob discovery tool - exposes interactive parameters for the current use case
  server.tool(
    'list_knobs',
    description:
        'A tool for obtaining information about all available knobs for the currently selected use case, including their names, types, descriptions, and current values.',
    callback: ({args, extra}) async {
      final knobs = state.knobs;
      final knobsJson = _convertKnobsToJson(state, knobs);

      return CallToolResult.fromContent(
        content: [
          TextContent(
            text: knobsJson,
          ),
        ],
      );
    },
  );

  // Knob state inspection tool - reads individual knob values
  server.tool(
    'get_knob_value',
    description:
        'A tool for retrieving the current value of a specific knob in the currently selected use case.',
    toolInputSchema: const ToolInputSchema(
      properties: {
        'knobName': {
          'type': 'string',
          'description': 'The name/label of the knob to retrieve the value for',
        },
      },
      required: ['knobName'],
    ),
    callback: ({args, extra}) async {
      final knobName = args?['knobName'] as String?;

      if (knobName == null) {
        return CallToolResult.fromContent(
          content: [
            const TextContent(
              text: 'Missing required parameter: knobName is required',
            ),
          ],
        );
      }

      try {
        final result = _getKnobValue(state, knobName);
        return CallToolResult.fromContent(
          content: [TextContent(text: result)],
        );
      } catch (e) {
        return CallToolResult.fromContent(
          content: [TextContent(text: 'Error retrieving knob value: $e')],
        );
      }
    },
  );

  // Knob manipulation tool - dynamically adjusts component parameters
  server.tool(
    'update_knob_value',
    description:
        'A tool for updating the value of a specific knob in the currently selected use case. This will change the knob\'s value and trigger a re-render of the use case.',
    toolInputSchema: const ToolInputSchema(
      properties: {
        'knobName': {
          'type': 'string',
          'description': 'The name/label of the knob to update',
        },
        'value': {
          'type': 'string',
          'description':
              'The new value for the knob (will be parsed according to knob type)',
        },
      },
      required: ['knobName', 'value'],
    ),
    callback: ({args, extra}) async {
      final knobName = args?['knobName'] as String?;
      final value = args?['value'] as String?;

      if (knobName == null || value == null) {
        return CallToolResult.fromContent(
          content: [
            const TextContent(
              text:
                  'Missing required parameters: knobName and value are required',
            ),
          ],
        );
      }

      try {
        final result = _updateKnobValue(state, knobName, value);
        return CallToolResult.fromContent(
          content: [TextContent(text: result)],
        );
      } catch (e) {
        return CallToolResult.fromContent(
          content: [TextContent(text: 'Error updating knob value: $e')],
        );
      }
    },
  );

  return server;
}

/// Searches for use cases matching the given pattern with optional glob support.
/// Returns a structured result with matching use cases, their metadata, and search statistics.
Map<String, dynamic> _searchUseCases(
  WidgetbookState state,
  String pattern,
  int limit,
) {
  final allUseCases = state.root.leaves.whereType<WidgetbookUseCase>().toList();

  final effectiveLimit = limit.clamp(1, 100);

  bool Function(WidgetbookUseCase) searchPredicate;

  if (pattern.contains('*') || pattern.contains('?')) {
    final regexPattern = _globToRegex(pattern);
    final regex = RegExp(regexPattern, caseSensitive: false);

    searchPredicate =
        (useCase) =>
            regex.hasMatch(useCase.name) ||
            regex.hasMatch(useCase.path) ||
            (useCase.parent?.name != null &&
                regex.hasMatch(useCase.parent!.name));
  } else {
    final lowerPattern = pattern.toLowerCase();
    searchPredicate =
        (useCase) =>
            useCase.name.toLowerCase().contains(lowerPattern) ||
            useCase.path.toLowerCase().contains(lowerPattern) ||
            (useCase.parent?.name != null &&
                useCase.parent!.name.toLowerCase().contains(lowerPattern));
  }

  final matchingUseCases =
      allUseCases.where(searchPredicate).take(effectiveLimit).toList();

  final results =
      matchingUseCases.map((useCase) {
        final parentComponent = useCase.parent;
        return {
          'name': useCase.name,
          'path': useCase.path,
          'componentName': parentComponent?.name,
          'componentPath': parentComponent?.path,
          'designLink': useCase.designLink,
          'type': useCase.runtimeType.toString(),
          'depth': useCase.depth,
        };
      }).toList();

  return {
    'pattern': pattern,
    'results': results,
    'totalFound': matchingUseCases.length,
    'totalSearched': allUseCases.length,
    'limitApplied': effectiveLimit,
    'hasMore': allUseCases.where(searchPredicate).length > effectiveLimit,
    'summary':
        'Found ${matchingUseCases.length} use cases matching "$pattern"'
        '${matchingUseCases.length == effectiveLimit ? " (limited to $effectiveLimit)" : ""}'
        ' out of ${allUseCases.length} total use cases',
  };
}

/// Converts a glob pattern to a regular expression.
/// Supports * (any characters) and ? (single character) wildcards.
String _globToRegex(String glob) {
  var pattern = RegExp.escape(glob);

  pattern = pattern.replaceAll(r'\*', '.*');
  pattern = pattern.replaceAll(r'\?', '.');

  pattern = pattern.replaceAll(r'\*\*/\*', r'.*');
  pattern = pattern.replaceAll(r'/\*\*/', r'/.*?/');

  return '^$pattern\$';
}

/// Serializes the Widgetbook directory tree structure for external consumption.
/// Enables MCP clients to understand the hierarchical organization of components and use cases.
String _convertDirectoriesToJson(
  List<WidgetbookNode> directories, {
  bool structureOnly = false,
  int? maxDepth,
}) {
  final directoriesMap =
      directories
          .map(
            (node) => _nodeToMap(
              node,
              structureOnly: structureOnly,
              maxDepth: maxDepth,
            ),
          )
          .toList();
  return jsonEncode(directoriesMap);
}

/// Recursively converts Widgetbook nodes into a flat map structure with metadata.
/// Preserves essential navigation information including paths, hierarchy depth, and design links.
Map<String, dynamic> _nodeToMap(
  WidgetbookNode node, {
  bool structureOnly = false,
  int? maxDepth,
  int currentDepth = 0,
}) {
  if (maxDepth != null && currentDepth >= maxDepth) {
    return <String, dynamic>{
      'name': node.name,
      'path': node.path,
      'type': node.runtimeType.toString(),
      'isLeaf': node.isLeaf,
      'depth': node.depth,
      'count': node.count,
      'truncated': true,
    };
  }

  final map = <String, dynamic>{
    'name': node.name,
    'path': node.path,
    'type': node.runtimeType.toString(),
    'isLeaf': node.isLeaf,
    'depth': node.depth,
    'count': node.count,
  };

  if (!structureOnly && node is WidgetbookUseCase) {
    map['designLink'] = node.designLink;
  }

  if (structureOnly && node is WidgetbookUseCase) {
    return map;
  }

  if (node.children != null && node.children!.isNotEmpty) {
    map['children'] =
        node.children!
            .map(
              (child) => _nodeToMap(
                child,
                structureOnly: structureOnly,
                maxDepth: maxDepth,
                currentDepth: currentDepth + 1,
              ),
            )
            .toList();
  }

  return map;
}

/// Serializes addon configuration metadata for external inspection and manipulation.
/// Exposes field schemas that enable dynamic configuration changes via MCP tools.
String _convertAddonsToJson(List<WidgetbookAddon>? addons) {
  if (addons == null || addons.isEmpty) {
    return jsonEncode([]);
  }

  final addonsMap = addons.map(_addonToMap).toList();
  return jsonEncode(addonsMap);
}

/// Extracts comprehensive addon metadata including configurable field definitions.
/// Field information enables MCP clients to understand valid configuration options and constraints.
Map<String, dynamic> _addonToMap(WidgetbookAddon addon) {
  final map = <String, dynamic>{
    'name': addon.name,
    'groupName': addon.groupName,
    'description': addon.description,
    'isNullable': addon.isNullable,
    'type': addon.runtimeType.toString(),
    'fields': addon.fields.map((field) => field.toFullJson()).toList(),
  };

  return map;
}

/// Performs runtime modification of addon configuration with type validation.
/// Integrates with Widgetbook's state management to ensure consistent UI updates.
String _updateAddonField(
  WidgetbookState state,
  String addonName,
  String fieldName,
  String value,
) {
  final addon = state.addons?.firstWhere(
    (addon) => addon.name == addonName,
    orElse: () => throw ArgumentError('Addon "$addonName" not found'),
  );

  if (addon == null) {
    throw ArgumentError('No addons available');
  }

  final field = addon.fields.firstWhere(
    (field) => field.name == fieldName,
    orElse:
        () =>
            throw ArgumentError(
              'Field "$fieldName" not found in addon "$addonName"',
            ),
  );

  // Type-safe value parsing prevents runtime errors in the UI
  String parsedValue;
  try {
    parsedValue = _validateAndParseFieldValue(field, value);
  } catch (e) {
    throw ArgumentError(
      'Invalid value "$value" for field "$fieldName" of type ${field.type.name}: $e',
    );
  }

  // Trigger state change to update the UI immediately
  state.updateQueryField(
    group: addon.groupName,
    field: fieldName,
    value: parsedValue,
  );

  return 'Successfully updated "$fieldName" in addon "$addonName" to "$value"';
}

/// Extracts current addon field values from the active Widgetbook state.
/// Resolves values from URL query parameters with fallback to default values.
String _getAddonFieldValue(
  WidgetbookState state,
  String addonName,
  String fieldName,
) {
  final addon = state.addons?.firstWhere(
    (addon) => addon.name == addonName,
    orElse: () => throw ArgumentError('Addon "$addonName" not found'),
  );

  if (addon == null) {
    throw ArgumentError('No addons available');
  }

  final field = addon.fields.firstWhere(
    (field) => field.name == fieldName,
    orElse:
        () =>
            throw ArgumentError(
              'Field "$fieldName" not found in addon "$addonName"',
            ),
  );

  // Decode from URL state - maintains consistency with UI display
  final groupMap = FieldCodec.decodeQueryGroup(
    state.queryParams[addon.groupName],
  );
  final currentValue = field.valueFrom(groupMap);

  return 'Field "$fieldName" in addon "$addonName" has current value: ${currentValue ?? field.initialValue}';
}

/// Serializes knob definitions and current values for the active use case.
/// Enables external tools to understand and manipulate component parameters dynamically.
String _convertKnobsToJson(WidgetbookState state, KnobsRegistry knobs) {
  if (knobs.isEmpty) {
    return jsonEncode([]);
  }

  final knobsMap =
      knobs.keys.map((knobName) {
        final knob = knobs[knobName]!;
        final queryGroup = FieldCodec.decodeQueryGroup(
          state.queryParams['knobs'],
        );

        return {
          'name': knob.name,
          'label': knob.label,
          'description': knob.description,
          'type': knob.runtimeType.toString(),
          'initialValue': knob.initialValue,
          'currentValue': _getKnobCurrentValue(knob, queryGroup),
          'isNullable': knob.isNullable,
          'fields': knob.fields.map((field) => field.toFullJson()).toList(),
        };
      }).toList();

  return jsonEncode(knobsMap);
}

/// Safely resolves knob values from URL state with graceful error handling.
/// Falls back to initial values when parsing fails to maintain UI stability.
dynamic _getKnobCurrentValue(Knob knob, Map<String, String> queryGroup) {
  try {
    return knob.valueFromQueryGroup(queryGroup) ?? knob.initialValue;
  } catch (e) {
    return knob.initialValue;
  }
}

/// Inspects individual knob state with type information for debugging purposes.
String _getKnobValue(WidgetbookState state, String knobName) {
  final knob = state.knobs[knobName];

  if (knob == null) {
    throw ArgumentError('Knob "$knobName" not found');
  }

  final queryGroup = FieldCodec.decodeQueryGroup(
    state.queryParams['knobs'],
  );

  final currentValue = _getKnobCurrentValue(knob, queryGroup);

  return 'Knob "$knobName" has current value: $currentValue (type: ${knob.runtimeType})';
}

/// Dynamically modifies knob values with comprehensive type validation.
/// Triggers immediate component re-rendering through state management integration.
String _updateKnobValue(WidgetbookState state, String knobName, String value) {
  final knob = state.knobs[knobName];

  if (knob == null) {
    throw ArgumentError('Knob "$knobName" not found');
  }

  // Prevent type mismatches that could crash the component
  String parsedValue;
  try {
    parsedValue = _validateAndParseKnobValue(knob, value);
  } catch (e) {
    throw ArgumentError(
      'Invalid value "$value" for knob "$knobName" of type ${knob.runtimeType}: $e',
    );
  }

  // Synchronize with Widgetbook's reactive state system
  state.updateQueryField(
    group: 'knobs',
    field: knobName,
    value: parsedValue,
  );

  return 'Successfully updated knob "$knobName" to "$value"';
}

/// Validates knob input by delegating to the primary field's type system.
/// Ensures consistency between knob definitions and their underlying field constraints.
String _validateAndParseKnobValue(Knob knob, String value) {
  if (knob.fields.isEmpty) {
    throw ArgumentError('Knob has no fields to validate against');
  }

  final primaryField = knob.fields.first;
  return _validateAndParseFieldValue(primaryField, value);
}

/// Comprehensive field value validation with type-specific parsing rules.
/// Prevents runtime errors by enforcing data type constraints at the MCP boundary.
String _validateAndParseFieldValue(Field field, String value) {
  switch (field.type.name) {
    case 'boolean':
      final boolValue = value.toLowerCase();
      if (boolValue == 'true' || boolValue == 'false') {
        return boolValue;
      }
      throw ArgumentError('Boolean field expects "true" or "false"');

    case 'string':
      return value;

    case 'int':
      final intValue = int.tryParse(value);
      if (intValue != null) {
        return value;
      }
      throw ArgumentError('Integer field expects a valid number');

    case 'double':
      final doubleValue = double.tryParse(value);
      if (doubleValue != null) {
        return value;
      }
      throw ArgumentError('Double field expects a valid number');

    case 'color':
      // Enforce standard hex color format for UI consistency
      if (value.startsWith('#') && (value.length == 7 || value.length == 9)) {
        final hexValue = value.substring(1);
        if (RegExp(r'^[0-9A-Fa-f]+$').hasMatch(hexValue)) {
          return value;
        }
      }
      throw ArgumentError(
        'Color field expects hex format (#RRGGBB or #AARRGGBB)',
      );

    default:
      // Delegate to field codec for custom validation logic
      return value;
  }
}
