import 'package:widgetbook_exception/widgetbook_exception.dart';

class WidgetbookDeployFailure implements WidgetbookException {
  WidgetbookDeployFailure({String? message})
      : _message =
            message ??= 'An error occurred while deploying your widgetbook to '
                'Widgetbook Cloud. Please try again';

  final String? _message;

  @override
  String get message => _message!;
}

class WidgetbookPublishReviewFailure implements WidgetbookException {
  WidgetbookPublishReviewFailure({String? message})
      : _message =
            message ??= 'An error occurred while deploying your widgetbook '
                'review to Widgetbook Cloud. Please try again';

  final String? _message;

  @override
  String get message => _message!;
}

class DirectoryNotFoundFailure implements WidgetbookException {
  DirectoryNotFoundFailure({String? message})
      : _message = message ??= 'Directory does not exist.';

  final String? _message;

  @override
  String get message => _message!;
}

class FileNotFoundFailure implements WidgetbookException {
  FileNotFoundFailure({String? message})
      : _message = message ??= 'File does not exist';

  final String? _message;

  @override
  String get message => _message!;
}

class ActorNotFoundFailure implements WidgetbookException {
  ActorNotFoundFailure({String? message})
      : _message = message ??= 'Actor is a required parameter';

  final String? _message;

  @override
  String get message => _message!;
}

class RepositoryNotFoundFailure implements WidgetbookException {
  RepositoryNotFoundFailure({String? message})
      : _message = message ??= 'Respository is a required parameter';

  final String? _message;

  @override
  String get message => _message!;
}

class WidgetbookApiFailure implements WidgetbookException {
  WidgetbookApiFailure({String? message})
      : _message = message ??=
            'An Error occured while uploading build to Widgetbook Cloud';

  final String? _message;

  @override
  String get message => _message!;
}
