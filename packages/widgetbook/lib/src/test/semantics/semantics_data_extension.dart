import 'package:flutter/semantics.dart';

import 'json_helpers.dart';
import 'semantics_flags_extension.dart';

extension SemanticsDataExtension on SemanticsData {
  Map<String, dynamic> toJson() {
    final properties = <String, dynamic>{};

    // Flags collection
    if (!flagsCollection.hasDefaultValues) {
      properties['flagsCollection'] = flagsCollection.toJson();
    }

    addInt(properties, 'actions', actions);
    addString(properties, 'identifier', identifier);
    addString(properties, 'label', label);
    addString(properties, 'value', value);
    addString(properties, 'increasedValue', increasedValue);
    addString(properties, 'decreasedValue', decreasedValue);
    addString(properties, 'hint', hint);
    addString(properties, 'tooltip', tooltip);
    addInt(properties, 'headingLevel', headingLevel);
    addEnum(properties, 'textDirection', textDirection);
    addNullableToString(properties, 'textSelection', textSelection);
    addNullable(properties, 'scrollChildCount', scrollChildCount);
    addNullable(properties, 'scrollIndex', scrollIndex);
    addNullable(properties, 'scrollPosition', scrollPosition);
    addNullable(properties, 'scrollExtentMax', scrollExtentMax);
    addNullable(properties, 'scrollExtentMin', scrollExtentMin);
    addNullable(properties, 'platformViewId', platformViewId);
    addNullable(properties, 'maxValueLength', maxValueLength);
    addNullable(properties, 'currentValueLength', currentValueLength);
    addNullable(properties, 'linkUrl', linkUrl);
    // Serialize as array [left, top, right, bottom] in fromLTRB format
    if (!rect.isEmpty) {
      properties['rect'] = [rect.left, rect.top, rect.right, rect.bottom];
    }
    addCollection(properties, 'tags', tags, (t) => t.name);
    // Transform (serialize as flat array of 16 values)
    if (transform != null) {
      properties['transform'] = transform!.storage;
    }
    addCollection(
      properties,
      'customSemanticsActionIds',
      customSemanticsActionIds,
      (e) => e.toString(),
    );
    addEnum(properties, 'role', role);
    addCollection(properties, 'controlsNodes', controlsNodes);
    addEnum(properties, 'validationResult', validationResult);
    addEnum(properties, 'inputType', inputType);
    addNullableToString(properties, 'locale', locale);

    return properties;
  }
}
