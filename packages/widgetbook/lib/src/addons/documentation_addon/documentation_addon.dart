import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/atom-one-dark.dart';
import 'package:flutter_highlighter/themes/atom-one-light.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_resizable_container/flutter_resizable_container.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// An addon that displays documentation for the widget.
///
/// The documentation is displayed in a markdown format.
///
/// The documentation is loaded from a markdown file in the assets folder.
/// The path to the markdown file is determined by the query parameter `path`.
/// Example: `?path=dss-components/form/textdynamicinput/textdynamicinput.percent`
/// give the path to the markdown file `assets/markdown/dss-components/form/textdynamicinput/textdynamicinput.percent.md`
///
/// The documentation is displayed in a resizable container.
///
/// The documentation can be toggled on and off using the `documentation` field.
class DocumentationAddon extends WidgetbookAddon<bool> {
  DocumentationAddon({
    this.initialBool = true,
  }) : super(name: 'Documentation');
  final bool initialBool;

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    bool setting,
  ) {
    if (!setting) {
      return child.animate().fade();
    }
    final backgroundColor = (Theme.of(context).brightness == Brightness.light)
        ? const Color(0xFFFDFCFF)
        : const Color(0xFF1A1C1E);
    return FutureBuilder(
      future: loadMarkdown(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != '') {
          return ResizableContainer(
            direction: Axis.vertical,
            children: [
              ResizableChild(
                size: const ResizableSize.expand(flex: 2),
                child: Card(
                  color: backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        Center(
                          child: Text(
                            'Widget Documentation',
                            style: GoogleFonts.lato(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        child,
                      ],
                    ),
                  ),
                ),
              ),
              ResizableChild(
                child: (snapshot.hasData)
                    ? Card(
                        color: backgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MarkdownWithHighlight(
                                  markdown: snapshot.data ?? "")
                              .animate()
                              .fade(),
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ).animate().fade();
        }
        return Card(
          color: backgroundColor,
          child: Padding(padding: const EdgeInsets.all(8.0), child: child),
        ).animate().fade();
      },
    );
  }

  Future<String> loadMarkdown() async {
    try {
      return await rootBundle.loadString(
        "${kDebugMode ? "" : "assets/"}markdown/${Uri.base.queryParameters['path']}.md",
      );
    } catch (_) {
      return '';
    }
  }

  @override
  List<Field<bool>> get fields {
    return [
      BooleanField(
        name: 'documentation',
        initialValue: initialBool,
      ),
    ];
  }

  @override
  bool valueFromQueryGroup(Map<String, String> group) {
    return valueOf<bool>('documentation', group)!;
  }
}

class MarkdownWithHighlight extends StatelessWidget {
  const MarkdownWithHighlight({
    super.key,
    required this.markdown,
  });
  final String markdown;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Markdown(
      shrinkWrap: true,
      data: markdown,
      builders: {
        'code': _CodeElementBuilder(),
      },
      styleSheet: MarkdownStyleSheet(
        p: theme.bodySmall,
        strong: theme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
        code: GoogleFonts.lato(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          backgroundColor: const Color(0xff282c34),
        ),
        codeblockDecoration: BoxDecoration(
          color: const Color(0xff282c34),
          borderRadius: BorderRadius.circular(5.0),
        ),
        checkbox: theme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
        h1: theme.headlineMedium,
        h2: theme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        h3: theme.bodyLarge,
        h4: theme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        h5: theme.bodyMedium,
        h6: theme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
        listBullet: theme.bodySmall,
      ),
      onTapLink: (text, url, title) {
        if (url != null) {
          launchUrl(
            Uri.parse(url),
          );
        }
      },
      selectable: true,
    );
  }
}

class _CodeElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    var language = '';

    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String;
      language = lg.substring(9);
    }
    return HighlightView(
      element.textContent,
      language: language,
      theme: MediaQueryData.fromView(
                      RendererBinding.instance.renderViews.first.flutterView)
                  .platformBrightness ==
              Brightness.light
          ? atomOneLightTheme
          : atomOneDarkTheme,
      padding: const EdgeInsets.all(8.0),
      textStyle: preferredStyle ?? GoogleFonts.robotoMono(),
    );
  }
}
