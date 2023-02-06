## 2.2.0-beta.7

 - **FIX**: :bug: reads actor and repository including newline. ([3bc05624](https://github.com/widgetbook/widgetbook/commit/3bc05624c608a5cbd7abb70cf20fda703110ca53))
 - **FIX**: :bug: bad revision on git diff. ([7019e1a9](https://github.com/widgetbook/widgetbook/commit/7019e1a91b09f8d7702f605f9cec8888d6d6e428))
 - **FEAT**: :memo: updated widgetbook git license and add 2 features. ([097be845](https://github.com/widgetbook/widgetbook/commit/097be8458ad5cfd16d2eaf886644e6a85f753e41))
 - **FEAT**: :sparkles: add forked git package. ([a7f77ebd](https://github.com/widgetbook/widgetbook/commit/a7f77ebd60e22ae62e39af201bf600e0fa098a8a))

## 2.2.0-beta.6

- feat: add `getActorName`, `getRepositoryName`

## 2.1.0

- feat: add API for `git diff`

## 2.0.0

- Require Dart 2.12
- Support null-safety.

## 1.2.0

- Require Dart 2.10.5
- `GitDir.init` added an optional `initialBranch` parameter.

## 1.1.0

- Allow `BranchReference` to handle a repo in the "detached head" state.

## 1.0.1

- Improve logic of parsing commits.

## 1.0.0

- A **LOT** of breaking changes.

## 0.5.1+1

* Support Dart 2 stable releases.

* Drop support for Dart 1.

## 0.5.1

* `GitDir.fromExisting` added a `allowSubdirectory` parameter.

## 0.5.0

* Remove unsupported dependencies.

## 0.4.4+3

* Strong-mode fixes.

## 0.4.4+2

* Internal refactoring.

## 0.4.4+1

* Run `git` in the shell – trying to address issues on Windows.

## 0.4.4

* Use `which` package to try harder to find `git` executable.

## 0.4.3

* `GitDir` added `updateBranchWithDirectoryContents`.

## 0.4.2

* Migrated code to Dart 1.9 `async`.

* Improved testing.

## 0.4.1+2

* Updated max version of `bot` dependency.

## 0.4.1+1

* Updated `hop` and added `hop_unittest` dev dependencies.

## 0.4.1 - 2014-05-06

 * Tweaks to `Commit` to stop using deperecated APIs from `bot`.
 * Updated constraint on `bot` package.

## 0.4.0 - 2014-04-12
 * Made fields on `TreeEntry` final.
 * A lot of source clean up.

## 0.3.0 - 2014-03-17
 * **BREAKING** `PopulateTempDir` typedef.
 * **BREAKING** `GitDir.populateBranch` - moving away from `TempDir` from `bot_io`
 * Removed a number of package dependencies

## 0.2.1+1 - 2014-03-16
 * Moved `scheduled_test` dependency to `dev_dependencies`

## 0.2.1 - 2014-03-16
 * **Deprecated** `PopulateTempDir` typedef.
 * **Deprecated** `GitDir.populateBranch` - moving away from `TempDir` from `bot_io`
 * **NEW!** `GitDir.updateBranch` like `populateBranch`, but exposes a `Directory`

## 0.2.0 - 2014-03-04
 * Supporting next release of `bot_io`
 * Fixed `hop_runner`
 * Removed deprecated `Git` class.

## 0.1.0 - 2014-02-15
 * First release
 * Maintains 100% compatibility with the `bot_git` library from the `bot_io`
   package as of release `0.25.1+2`.
