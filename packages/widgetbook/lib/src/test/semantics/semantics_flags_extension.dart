import 'package:flutter/semantics.dart';

import 'json_helpers.dart';

extension SemanticsFlagsExtension on SemanticsFlags {
  Map<String, dynamic> toJson() {
    final properties = <String, dynamic>{};

    // Only add non-default values
    addInt(properties, 'isChecked', isChecked.value);
    addInt(properties, 'isSelected', isSelected.value);
    addInt(properties, 'isEnabled', isEnabled.value);
    addInt(properties, 'isToggled', isToggled.value);
    addInt(properties, 'isExpanded', isExpanded.value);
    addInt(properties, 'isRequired', isRequired.value);
    addInt(properties, 'isFocused', isFocused.value);
    addBool(properties, 'isButton', isButton);
    addBool(properties, 'isTextField', isTextField);
    addBool(
      properties,
      'isInMutuallyExclusiveGroup',
      isInMutuallyExclusiveGroup,
    );
    addBool(properties, 'isHeader', isHeader);
    addBool(properties, 'isObscured', isObscured);
    addBool(properties, 'scopesRoute', scopesRoute);
    addBool(properties, 'namesRoute', namesRoute);
    addBool(properties, 'isHidden', isHidden);
    addBool(properties, 'isImage', isImage);
    addBool(properties, 'isLiveRegion', isLiveRegion);
    addBool(properties, 'hasImplicitScrolling', hasImplicitScrolling);
    addBool(properties, 'isMultiline', isMultiline);
    addBool(properties, 'isReadOnly', isReadOnly);
    addBool(properties, 'isLink', isLink);
    addBool(properties, 'isSlider', isSlider);
    addBool(properties, 'isKeyboardKey', isKeyboardKey);

    return properties;
  }

  bool get hasDefaultValues {
    return isChecked.value == 0 &&
        isSelected.value == 0 &&
        isEnabled.value == 0 &&
        isToggled.value == 0 &&
        isExpanded.value == 0 &&
        isRequired.value == 0 &&
        isFocused.value == 0 &&
        !isButton &&
        !isTextField &&
        !isInMutuallyExclusiveGroup &&
        !isHeader &&
        !isObscured &&
        !scopesRoute &&
        !namesRoute &&
        !isHidden &&
        !isImage &&
        !isLiveRegion &&
        !hasImplicitScrolling &&
        !isMultiline &&
        !isReadOnly &&
        !isLink &&
        !isSlider &&
        !isKeyboardKey;
  }
}
