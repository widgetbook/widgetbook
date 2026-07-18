/// Building blocks for custom snapshot drivers.
///
/// These are the pieces `testWidgetbook` uses to turn a captured scenario into
/// the `build/.widgetbook` cache the Widgetbook CLI uploads. They are exposed
/// so alternative drivers — e.g. an on-device `integration_test` runner that
/// captures platform-backed widgets (`video_player`, `pdfrx`) — can produce the
/// same `ScenarioMetadata` without depending on `integration_test` from the
/// core library. See `examples/integration_test_example`.
library;

export 'src/test/scenario_metadata.dart' show ScenarioMetadata;
export 'src/test/semantics/semantics_tree_serializer.dart'
    show SemanticsTreeSerializer;
