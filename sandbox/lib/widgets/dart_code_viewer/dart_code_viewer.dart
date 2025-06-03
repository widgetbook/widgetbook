import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pre_highlighter.dart';

class DartCodeViewer extends StatelessWidget {
  const DartCodeViewer(this.data, {super.key, this.height, this.width});

  final String data;
  final double? height;
  final double? width;

  Future<void> _copyToClipboard(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: data));

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Copied to Clipboard')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final codeTextStyle = theme.textTheme.bodyLarge;

    // Default styles based on the theme
    final defaultBaseStyle = codeTextStyle?.copyWith(
      color: Colors.blue[300],
      fontFamily: 'monospace',
    );
    final defaultClassStyle = codeTextStyle?.copyWith(
      color: Colors.green[600],
      fontFamily: 'monospace',
    );
    final defaultCommentStyle = codeTextStyle?.copyWith(
      color: Colors.grey[500],
      fontFamily: 'monospace',
    );
    final defaultConstantStyle = codeTextStyle?.copyWith(
      color: Colors.blue[600],
      fontFamily: 'monospace',
    );
    final defaultKeywordStyle = codeTextStyle?.copyWith(
      color: Colors.blue[600],
      fontFamily: 'monospace',
    );
    final defaultNumberStyle = codeTextStyle?.copyWith(
      color: Colors.orange[600],
      fontFamily: 'monospace',
    );
    final defaultPunctuationStyle = codeTextStyle?.copyWith(
      color: Colors.white,
      fontFamily: 'monospace',
    );
    final defaultStringStyle = codeTextStyle?.copyWith(
      color: Colors.orange[700],
      fontFamily: 'monospace',
    );
    final defaultMethodStyle = codeTextStyle?.copyWith(
      color: Colors.yellow[200],
      fontFamily: 'monospace',
    );

    final richTextCode = _codifyString(
      data,
      defaultBaseStyle,
      defaultClassStyle,
      defaultCommentStyle,
      defaultConstantStyle,
      defaultKeywordStyle,
      defaultNumberStyle,
      defaultPunctuationStyle,
      defaultStringStyle,
      defaultMethodStyle,
    );

    return Container(
      color: Colors.black,
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () => _copyToClipboard(context),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SelectableText.rich(
                TextSpan(children: [richTextCode as TextSpan]),
                textDirection: TextDirection.ltr,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InlineSpan _codifyString(
    String content,
    TextStyle? baseStyle,
    TextStyle? classStyle,
    TextStyle? commentStyle,
    TextStyle? constantStyle,
    TextStyle? keywordStyle,
    TextStyle? numberStyle,
    TextStyle? punctuationStyle,
    TextStyle? stringStyle,
    TextStyle? methodStyle,
  ) {
    final textSpans = <TextSpan>[];
    final codeSpans = DartSyntaxPreHighlighter().format(content);

    for (final span in codeSpans) {
      textSpans.add(
        _stringToTextSpan(
          span.toString(),
          baseStyle,
          classStyle,
          commentStyle,
          constantStyle,
          keywordStyle,
          numberStyle,
          punctuationStyle,
          stringStyle,
          methodStyle,
        ),
      );
    }

    return TextSpan(children: textSpans);
  }

  TextSpan _stringToTextSpan(
    String string,
    TextStyle? baseStyle,
    TextStyle? classStyle,
    TextStyle? commentStyle,
    TextStyle? constantStyle,
    TextStyle? keywordStyle,
    TextStyle? numberStyle,
    TextStyle? punctuationStyle,
    TextStyle? stringStyle,
    TextStyle? methodStyle,
  ) {
    final styleString = RegExp(r'codeStyle.\w*').firstMatch(string)?.group(0);
    final textString = RegExp('\'.*\'').firstMatch(string)?.group(0);
    final subString = textString!.substring(1, textString.length - 1);

    return TextSpan(
      style: () {
        switch (styleString) {
          case 'codeStyle.baseStyle':
            return baseStyle;
          case 'codeStyle.numberStyle':
            return numberStyle;
          case 'codeStyle.commentStyle':
            return commentStyle;
          case 'codeStyle.keywordStyle':
            return keywordStyle;
          case 'codeStyle.stringStyle':
            return stringStyle;
          case 'codeStyle.punctuationStyle':
            return punctuationStyle;
          case 'codeStyle.classStyle':
            return classStyle;
          case 'codeStyle.constantStyle':
            return constantStyle;
          case 'codeStyle.methodStyle':
            return methodStyle;
          default:
            return baseStyle;
        }
      }(),
      text: _decodeString(subString),
    );
  }

  String _decodeString(String string) {
    return string
        .replaceAll(r'\u000a', '\n')
        .replaceAll(r'\u0027', '\'')
        .replaceAll(r'\u0009', '\t')
        .replaceAll(r'\u0022', '"')
        .replaceAll(r'\u0024', '\$');
  }
}
