import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/providers/organizer_provider.dart';

class OrganizerProviderMock extends Mock implements OrganizerProvider {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return super.toString();
  }
}
