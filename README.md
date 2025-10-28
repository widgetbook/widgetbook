<img height=40 src="https://raw.githubusercontent.com/widgetbook/widgetbook/2107e1afe2217e8ecde56c6ade1fd3706c3e6570/docs/assets/WidgetbookLogo.svg">

[![Discord](https://img.shields.io/discord/879618555560218625?color=blue&style=flat-square&logo=discord)](https://discord.com/invite/zT4AMStAJA)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg?style=flat-square)](https://pub.dev/packages/very_good_analysis) 
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/widgetbook/widgetbook/widgetbook.yaml?branch=main)

Widgetbook is a sandbox for building widgets and screens in isolation. It helps you develop and share hard-to-reach states and edge cases without needing to run your whole app. Inspired by Storybook.js.

[![Widgetbook Demo](https://github.com/widgetbook/widgetbook/blob/main/docs/assets/screenshots/WidgetbookOSS.png?raw=true)](https://demo.widgetbook.io/)

## Open-Source Widgetbook

- 🧱 **Build UI components and pages in isolation**. Implement components and pages without needing to fuss with data, APIs, or business logic.
- 👀 **Mock hard-to-reach edge cases**. Render widgets in key states that are tricky to reproduce in an app. Then save those states as use-case to revisit during development, testing, and QA.
- 📙 **Catalog all of your widgets**. Create your own widget library providing you with a great overview of what you have already built.

🎥 Watch a [2-minute demo video](https://youtu.be/sGRetvJ-zZI) from Google's Flutter team.

## Widgetbook Cloud

[![Widgetbook Cloud Demo](https://github.com/widgetbook/widgetbook/blob/main/docs/assets/screenshots/WidgetbookCloud.png?raw=true)](https://youtu.be/l3tj9VvkjLs)

Widgetbook Cloud is a managed hosting solution for Widgetbook that allows you to run golden tests to detect and review all UI changes in your pull-request.

- 🌍 **Share your Widgetbook with your team**. Publish your Widgetbook build for other Developers, Designers, PMs or Clients to reference. Everyone can check that the UI looks right without touching code.
- 🏅 **Golden Tests**. Run zero-configuration golden tests (visual regression tests) on your widgets across all states, devices, themes, text scale factors, etc. to detect all changes.
- 🧪 **Visual Pull Requests**. Detect and review all UI changes in your pull-request.
- 🎨 **Figma Reviews**. Connect your your Figma designs to review your Flutter widget next to the original Figma design.

🎥 Watch a [1-minute demo video](https://youtu.be/l3tj9VvkjLs).

[Get access now! ➡️](https://app.widgetbook.io/sign-up)

# Packages

The widgetbook repository contains of the Widgetbook packages which are located at [/widgetbook/packages/](https://github.com/widgetbook/widgetbook/tree/main/packages).

The following packages exist:

| Package           | Pub |
| ----------------- | --------------------------------- |
| [widgetbook](https://github.com/widgetbook/widgetbook/tree/main/packages/widgetbook) | [![Pub Version](https://img.shields.io/pub/v/widgetbook?style=flat-square)](https://pub.dev/packages/widgetbook) | 
| [widgetbook_annotation](https://github.com/widgetbook/widgetbook/tree/main/packages/widgetbook_annotation) | [![Pub Version](https://img.shields.io/pub/v/widgetbook_annotation?style=flat-square)](https://pub.dev/packages/widgetbook_annotation)  | 
| [widgetbook_generator](https://github.com/widgetbook/widgetbook/tree/main/packages/widgetbook_generator) | [![Pub Version](https://img.shields.io/pub/v/widgetbook_generator?style=flat-square)](https://pub.dev/packages/widgetbook_generator) | 

# Examples

All example apps are located at [/widgetbook/examples/](https://github.com/widgetbook/widgetbook/tree/main/examples/).

## Running the examples in VS Code

You can run the example apps in VS Code by using the predefined launch configurations. The following configurations exist:

| Configuration | Description |
| ------------- | ----------- |
| Debug widgetbook_generator | Launches the generated code from [package:widgetbook_generator](https://github.com/widgetbook/widgetbook/tree/main/packages/widgetbook_generator). Run `flutter pub run build_runner build` before! This is great to develop [package:widgetbook_generator](https://github.com/widgetbook/widgetbook/tree/main/packages/widgetbook_generator). |

# Contributions

We love the open source flutter community!💙 If you'd like to contribute to one or all Widgetbook packages, feel free to open a pull-request at any time. To give new contributors exciting first challenges, we're labelling some easy-to-fix issues "good first issue".

# Questions or Issues? 

If something does not feel right or if you have questions, feel free to contact us. You can do so by [creating an issue](https://github.com/widgetbook/widgetbook/issues) or [contacting us on discord](https://discord.gg/zT4AMStAJA).
