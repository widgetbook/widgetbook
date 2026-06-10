/// Metadata for generating code for a single constructor of a widget.
///
/// The [constructor] must be a constructor tear-off of the widget, e.g.
/// `Meta(MyButton.new)` or `Meta(MyButton.icon)`. Generated types for named
/// constructors are prefixed with the PascalCase constructor name,
/// e.g. `_IconStory` and `_IconArgs` for `MyButton.icon`.
///
/// By default, args are derived from the widget [constructor]'s parameters.
/// Provide [argsType] with a constructor tear-off of a custom args class to
/// derive them from that constructor instead, e.g.
/// `Meta(MyButton.new, argsType: MyButtonInput.new)`. Stories then require
/// a `builder` that maps the custom args to the widget.
///
/// Meta variables must be declared as `const`.
class Meta {
  const Meta(
    this.constructor, {
    this.argsType,
  });

  final Function constructor;
  final Function? argsType;
}
