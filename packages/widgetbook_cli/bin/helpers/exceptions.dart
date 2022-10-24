import 'package:widgetbook_exception/widgetbook_exception.dart';

class WidgetbookDeployException implements WidgetbookException {
  WidgetbookDeployException({String? message})
      : _message =
            message ??= 'An error occurred while deploying your widgetbook to '
                'Widgetbook Cloud. Please try again';

  final String? _message;

  @override
  String get message => _message!;
}

class WidgetbookPublishReviewException implements WidgetbookException {
  WidgetbookPublishReviewException({String? message})
      : _message =
            message ??= 'An error occurred while deploying your widgetbook '
                'review to Widgetbook Cloud. Please try again';

  final String? _message;

  @override
  String get message => _message!;
}

class DirectoryNotFoundException implements WidgetbookException {
  DirectoryNotFoundException({String? message})
      : _message = message ??= 'Directory does not exist.';

  final String? _message;

  @override
  String get message => _message!;
}

class FileNotFoundException implements WidgetbookException {
  FileNotFoundException({String? message})
      : _message = message ??= 'File does not exist';

  final String? _message;

  @override
  String get message => _message!;
}

class ActorNotFoundException implements WidgetbookException {
  ActorNotFoundException({String? message})
      : _message = message ??= 'Actor is a required parameter';

  final String? _message;

  @override
  String get message => _message!;
}

class RepositoryNotFoundException implements WidgetbookException {
  RepositoryNotFoundException({String? message})
      : _message = message ??= 'Respository is a required parameter';

  final String? _message;

  @override
  String get message => _message!;
}

class WidgetbookApiException implements WidgetbookException {
  WidgetbookApiException({String? message})
      : _message = message ??=
            'An Error occured while uploading build to Widgetbook Cloud';

  final String? _message;

  @override
  String get message => _message!;
}
