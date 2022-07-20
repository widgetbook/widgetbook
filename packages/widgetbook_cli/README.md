# Overview

`widgetbook_cli` allows developers to upload their Widgetbook to Widgetbook Cloud.

Currently the CLI supports two features:
- uploading a [Widgetbook Build](/widgetbook-cloud/hosting)
- uploading a [Widgetbook Review](/widgetbook-cloud/review)

## Repository

To access the source code of the CLI visit the [Widgetbook repository](https://github.com/widgetbook/widgetbook/tree/main/packages/widgetbook_cli).

## Setup

The `widgetbook-cli` is available as the [widgetbook_cli](https://pub.dev/packages/widgetbook_cli) package.

Install the CLI globally by running: 

```bash
dart pub global activate widgetbook_cli
```

Run the CLI by using
```bash
widgetbook [<options>]
```

### Arguments

The CLI accepts the following arguments.

| Argument         | Mandatory | Description |
| ---------------- | --------- | ----------- |
| `--path`         | ➖        | The path to your project. Defaults to `./`. |
| `--api-key`      | ✅        | The project specific API key for Widgetbook Cloud. See [How to create an API key](/widgetbook-cloud/hosting#how-to-create-an-api-key).|
| `--branch`       | ➖        | The name of the branch for which the Widgetbook is uploaded. Defaults to the current git branch. |
| `--commit`       | ➖        | The SHA hash of the commit for which the Widgetbook is uploaded. Defaults to the last commit of the current git branch. |
| `--repository`   | ✅        | The name of the repository for which the Widgetbook is uploaded.|
| `--actor`        | ✅        | The username of the actor which triggered the build.|
| `--git-provider` | ➖        | The name of the Git provider. Allowed values: `GitHub`, `GitLab`, `BitBucket`, `Azure`, `Local`. Defaults to `Local` |
| `--base-branch`  | ➖        | The name of the pull-request's base branch. |
| `--base-commit`  | ➖        | The SHA hash of pull-request's base branch. Defaults to the last commit of `base-branch`, if `base-branch` is set. |

If `base-branch` or `base-commit` are omitted, a Widgetbook Build is created. 
If `base-branch` and `base-commit` are provided, a widgetbook Build and a Widgetbook Review is created.