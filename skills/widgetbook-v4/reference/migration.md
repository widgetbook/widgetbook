# Migration reference

## From Widgetbook v3

| v3 | v4 | Notes |
|---|---|---|
| `@UseCase(name: 'Default')` | `final $Default = _Story(name: 'Default')` | Run build_runner to generate `_Story` |
| `context.knobs.text(label: 'X')` | `StringArg('value')` in `_Args` | Args are generated from the constructor |
| `context.knobs.boolean(label: 'X')` | `BoolArg(true)` | |
| Addons only | Addons + Modes | Modes define concrete addon configurations |
| Widgetbook in `lib` / `test` / `widgetbook` | dedicated `widgetbook/` workspace package outside `lib` | See workspace structure in `reference/api-reference.md` |

Full v3 guide: https://docs.widgetbook.io/~v4/v4-migration

## From earlier v4 betas (the `Meta<T>()` form)

Earlier betas used a generic `Meta` and a separate `MetaWithArgs`. Current v4 uses a constructor tear-off.

- Replace `const meta = Meta<Widget>();` with `const meta = Meta(Widget.new);`. `Meta` must be `const`.
- Replace `const meta = MetaWithArgs<Widget, Args>();` with `const meta = Meta(Widget.new, argsType: Args.new);`.
- If the old `Meta` passed `name`, `path`, or `docsBuilder`, move those to a separate `ComponentMeta` (see `reference/api-reference.md`) and keep `const meta = Meta(Widget.new);` alongside it.
- Optionally add one `Meta` per additional constructor, e.g. `const iconMeta = Meta(Widget.icon);`.
- Run `dart run build_runner build -d` inside `widgetbook/`. This replaces the deprecated `flutter pub run build_runner build`.

`_Story`, `_Args`, and `_Scenario` usage for the default constructor is unchanged. For named constructors the generated types are prefixed with the PascalCase constructor name (`_IconStory`, `_IconArgs`, `_IconScenario`).
