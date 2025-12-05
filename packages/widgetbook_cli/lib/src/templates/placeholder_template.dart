import 'template.dart';

class PlaceholderTemplate extends Template {
  PlaceholderTemplate()
    : super(
        'lib/placeholder.stories.dart',
        '''
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

part 'placeholder.stories.book.dart';

const meta = Meta<Placeholder>();

final \$Default = _Story(
  name: 'Default',
);
''',
      );
}
