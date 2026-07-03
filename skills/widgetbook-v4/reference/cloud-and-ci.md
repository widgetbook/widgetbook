# Widgetbook Cloud and CI

Widgetbook Cloud hosts your catalogue and turns the snapshots from `flutter test` into reviewable visual pull requests. It runs golden tests across states, themes, devices, and text scales, surfaces accessibility changes between builds, and can show each widget next to its Figma design.

To connect it to a Flutter CI pipeline:

1. Create a project in Widgetbook Cloud and connect your Git repository.
2. Add the Widgetbook CLI to your CI job (`dart pub global activate widgetbook_cli`).
3. On each pull request, run `flutter test` from `widgetbook/` to generate snapshots into `widgetbook/build/.widgetbook`, then push the build with `widgetbook cloud build push`.
4. Cloud compares the pushed build against the base branch and posts a visual review on the PR, including golden diffs, accessibility changes, and Figma review where configured.

Store your Cloud API key as a CI secret rather than committing it. See the Widgetbook Cloud documentation for the exact CLI flags and ready-made workflow files (GitHub Actions, GitLab CI, and others).
