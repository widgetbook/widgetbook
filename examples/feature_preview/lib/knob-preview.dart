import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'widgets/colored_text_box.dart';
import 'widgets/datetime_text.dart';
import 'widgets/duration_text.dart';
import 'widgets/notification_badge.dart';
import 'widgets/online_status.dart';
import 'widgets/user_avatar.dart';

abstract class KnobPreview extends StatelessWidget {
  const KnobPreview({super.key});
}

@UseCase(type: KnobPreview, name: 'Int Input Knob')
Widget buildIntInputKnob(BuildContext context) {
  return NotificationBadge(
    count: context.knobs.int.input(label: 'count', initialValue: 100),
  );
}

@UseCase(type: KnobPreview, name: 'Int Input Nullable Knob')
Widget buildNullableIntInputKnob(BuildContext context) {
  return NotificationBadge(
    count: context.knobs.intOrNull.input(label: 'count'),
  );
}

@UseCase(type: KnobPreview, name: 'Int Slider Knob')
Widget buildIntSliderKnob(BuildContext context) {
  return NotificationBadge(
    count: context.knobs.int.slider(
      label: 'count',
      max: 100,
      divisions: 20,
      initialValue: 100,
    ),
  );
}

@UseCase(type: KnobPreview, name: 'Int Slider Nullable Knob')
Widget buildNullableIntSliderKnob(BuildContext context) {
  return NotificationBadge(
    count: context.knobs.intOrNull.slider(
      label: 'count',
      max: 100,
      divisions: 20,
    ),
  );
}

@UseCase(type: KnobPreview, name: 'Double Input Knob')
Widget buildDoubleInputKnob(BuildContext context) {
  return CircularProgressIndicator(
    value: context.knobs.double.input(label: 'value', initialValue: 0.2),
    backgroundColor: Colors.amber,
  );
}

@UseCase(type: KnobPreview, name: 'Double Input Nullable Knob')
Widget buildNullableDoubleInputKnob(BuildContext context) {
  return CircularProgressIndicator(
    value: context.knobs.doubleOrNull.input(label: 'value'),
    backgroundColor: Colors.amber,
  );
}

@UseCase(type: KnobPreview, name: 'Double Slider Knob')
Widget buildDoubleSliderKnob(BuildContext context) {
  return CircularProgressIndicator(
    value: context.knobs.double.slider(
      label: 'value',
      max: 1,
      divisions: 10,
      initialValue: 0.2,
    ),
    backgroundColor: Colors.amber,
  );
}

@UseCase(type: KnobPreview, name: 'Double Slider Nullable Knob')
Widget buildNullableDoubleSliderKnob(BuildContext context) {
  return CircularProgressIndicator(
    value: context.knobs.doubleOrNull.slider(
      label: 'value',
      max: 1,
      divisions: 10,
    ),
    backgroundColor: Colors.amber,
  );
}

@UseCase(type: KnobPreview, name: 'String Knob')
Widget buildStringKnob(BuildContext context) {
  return UserAvatar(
    name: context.knobs.string(label: 'name', initialValue: 'John Doe'),
  );
}

@UseCase(type: KnobPreview, name: 'String Nullable Knob')
Widget buildNullableStringKnob(BuildContext context) {
  return UserAvatar(
    name: context.knobs.stringOrNull(label: 'name', initialValue: 'John Doe'),
  );
}

@UseCase(type: KnobPreview, name: 'Bool Knob')
Widget buildBoolKnob(BuildContext context) {
  return Checkbox(
    value: context.knobs.boolean(label: 'value'),
    onChanged: (value) {},
  );
}

@UseCase(type: KnobPreview, name: 'Bool Nullable Knob')
Widget buildNullableBoolKnob(BuildContext context) {
  return Checkbox(
    value: context.knobs.booleanOrNull(label: 'value'),
    tristate: true,
    onChanged: (value) {},
  );
}

@UseCase(type: KnobPreview, name: 'Duration Knob')
Widget buildDurationKnob(BuildContext context) {
  return DurationText(duration: context.knobs.duration(label: 'duration'));
}

@UseCase(type: KnobPreview, name: 'Duration Nullable Knob')
Widget buildNullableDurationKnob(BuildContext context) {
  return DurationText(
    duration: context.knobs.durationOrNull(label: 'duration'),
  );
}

@UseCase(type: KnobPreview, name: 'DateTime Knob')
Widget buildDateTimeKnob(BuildContext context) {
  return DateTimeText(
    dateTime: context.knobs.dateTime(
      label: 'dateTime',
      initialValue: DateTime.now(),
      start: DateTime.now().subtract(const Duration(days: 30)),
      end: DateTime.now().add(const Duration(days: 30)),
    ),
  );
}

@UseCase(type: KnobPreview, name: 'DateTime Nullable Knob')
Widget buildNullableDateTimeKnob(BuildContext context) {
  return DateTimeText(
    dateTime: context.knobs.dateTimeOrNull(
      label: 'dateTime',
      start: DateTime.now().subtract(const Duration(days: 30)),
      end: DateTime.now().add(const Duration(days: 30)),
    ),
  );
}

@UseCase(type: KnobPreview, name: 'Color Knob')
Widget buildColorKnob(BuildContext context) {
  return ColoredTextBox(
    color: context.knobs.color(label: 'color', initialValue: Colors.red),
  );
}

@UseCase(type: KnobPreview, name: 'Color Nullable Knob')
Widget buildNullableColorKnob(BuildContext context) {
  return ColoredTextBox(color: context.knobs.colorOrNull(label: 'color'));
}

@UseCase(type: KnobPreview, name: 'Iterable Segmented Knob')
Widget buildIterableSegmentedKnob(BuildContext context) {
  final statuses = context.knobs.iterable.segmented<OnlineStatusType>(
    label: 'status',
    labelBuilder: (value) => value.name,
    options: [
      OnlineStatusType.online,
      OnlineStatusType.offline,
      OnlineStatusType.busy,
    ],
  );

  return Wrap(
    runSpacing: 8,
    spacing: 8,
    children: statuses.map((type) {
      return OnlineStatusBadge(
        status: type,
      );
    }).toList(),
  );
}

@UseCase(type: KnobPreview, name: 'Iterable Segmented Nullable Knob')
Widget buildIterableSegmentedNullableKnob(BuildContext context) {
  final statuses = context.knobs.iterableOrNull.segmented<OnlineStatusType>(
    label: 'status',
    labelBuilder: (value) => value.name,
    options: [
      OnlineStatusType.online,
      OnlineStatusType.offline,
      OnlineStatusType.busy,
    ],
  );

  return Wrap(
    runSpacing: 8,
    spacing: 8,
    children: statuses == null
        ? [const Text('Nothing to show')]
        : statuses.map((type) {
            return OnlineStatusBadge(
              status: type,
            );
          }).toList(),
  );
}

@UseCase(type: KnobPreview, name: 'Object Dropdown Knob')
Widget buildObjectDropdownKnob(BuildContext context) {
  return OnlineStatusBadge(
    status: context.knobs.object.dropdown<OnlineStatusType>(
      label: 'status',
      labelBuilder: (value) => value.name,
      options: [
        OnlineStatusType.online,
        OnlineStatusType.offline,
        OnlineStatusType.busy,
      ],
    ),
  );
}

@UseCase(type: KnobPreview, name: 'Object Dropdown Nullable Knob')
Widget buildObjectNullableDropdownKnob(BuildContext context) {
  return OnlineStatusBadge(
    status: context.knobs.objectOrNull.dropdown<OnlineStatusType>(
      label: 'status',
      labelBuilder: (value) => value.name,
      options: [
        OnlineStatusType.online,
        OnlineStatusType.offline,
        OnlineStatusType.busy,
      ],
    ),
  );
}

@UseCase(type: KnobPreview, name: 'Object Segmented Knob')
Widget buildObjectSegmentedKnob(BuildContext context) {
  return OnlineStatusBadge(
    status: context.knobs.object.segmented<OnlineStatusType>(
      label: 'status',
      labelBuilder: (value) => value.name,
      options: [
        OnlineStatusType.online,
        OnlineStatusType.offline,
        OnlineStatusType.busy,
      ],
    ),
  );
}

@UseCase(type: KnobPreview, name: 'Object Segmented Nullable Knob')
Widget buildObjectNullableSegmentedKnob(BuildContext context) {
  return OnlineStatusBadge(
    status: context.knobs.objectOrNull.segmented<OnlineStatusType>(
      label: 'status',
      labelBuilder: (value) => value.name,
      options: [
        OnlineStatusType.online,
        OnlineStatusType.offline,
        OnlineStatusType.busy,
      ],
    ),
  );
}
