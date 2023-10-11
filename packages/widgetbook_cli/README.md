<img height=40 src="https://raw.githubusercontent.com/widgetbook/widgetbook/2107e1afe2217e8ecde56c6ade1fd3706c3e6570/docs/assets/WidgetbookLogo.svg">

[![Discord](https://img.shields.io/discord/879618555560218625?color=blue&style=flat-square)](https://discord.com/invite/zT4AMStAJA)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg?style=flat-square)](https://pub.dev/packages/very_good_analysis)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/widgetbook/widgetbook/widgetbook-cli.yaml?branch=main)

# Widgetbook CLI

The CLI supports uploading [Widgetbook Builds](https://docs.widgetbook.io/widgetbook-cloud/hosting) & [Widgetbook Reviews](https://docs.widgetbook.io/widgetbook-cloud/review).

## Quick Start

```bash
# 🎯 Activate from https://pub.dev
dart pub global activate widgetbook_cli

# 🚀 Use CLI
widgetbook publish --api-key <key>
```

## Setup

The `widgetbook-cli` is available as the [widgetbook_cli](https://pub.dev/packages/widgetbook_cli) package.

Install the CLI globally by running: 

```bash
dart pub global activate widgetbook_cli
```

Run the CLI by using
```bash
widgetbook <command> [arguments]
```

## Publish a Widgetbook

An existing Widgetbook can be uploaded via the `publish` command.

### Arguments

The CLI accepts the following arguments.

| Argument         | Mandatory | Description |
| ---------------- | --------- | ----------- |
| `--path`         | ➖        | The path to your project. Defaults to `./`. |
| `--api-key`      | ✅        | The project specific API key for Widgetbook Cloud. See [How to create an API key](https://docs.widgetbook.io/widgetbook-cloud/hosting#how-to-create-an-api-key).|
| `--branch`       | ➖        | The name of the branch for which the Widgetbook is uploaded. Defaults to the current git branch. |
| `--commit`       | ➖        | The SHA hash of the commit for which the Widgetbook is uploaded. Defaults to the last commit of the current git branch. |
| `--repository`   | ➖        | The name of the repository for which the Widgetbook is uploaded.|
| `--actor`        | ➖        | The username of the actor which triggered the build.|
| `--base-branch`  | ➖        | The name of the pull-request's base branch. |

If `base-branch` is omitted, a **Widgetbook Build** is created.  
If `base-branch` is provided, a **Widgetbook Build** and a **Widgetbook Review** is created.

## Documentation

See [docs.widgetbook.io](https://docs.widgetbook.io) for docs & samples.
