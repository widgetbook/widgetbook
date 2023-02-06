## 3.0.0-beta.18

 - **REFACTOR**: :recycle: settings. ([254ebef6](https://github.com/widgetbook/widgetbook/commit/254ebef6fe38b2d8f3fc847366f4725ab9292ccb))
 - **REFACTOR**: :recycle: git usage. ([4f5db511](https://github.com/widgetbook/widgetbook/commit/4f5db511b5a6bb7e07b2ef440ebb97d0d5082048))
 - **FIX**: :bug: upload of properties. ([a9996bbd](https://github.com/widgetbook/widgetbook/commit/a9996bbd79f19ddc2fd2601fa5ba7f8a96f8c16f))
 - **FIX**: :bug: fails pipeline when no generator files exist. ([65ad1e67](https://github.com/widgetbook/widgetbook/commit/65ad1e67428ab7146c583871b9d58e6d5ed2ef7e))
 - **FIX**: :bug: reads actor and repository including newline. ([3bc05624](https://github.com/widgetbook/widgetbook/commit/3bc05624c608a5cbd7abb70cf20fda703110ca53))
 - **FIX**: :bug: bad revision on git diff. ([7019e1a9](https://github.com/widgetbook/widgetbook/commit/7019e1a91b09f8d7702f605f9cec8888d6d6e428))
 - **FIX**: 🐛 CLI fails on environments without terminal. ([d5101d56](https://github.com/widgetbook/widgetbook/commit/d5101d56140caaa86dae2caa28e13737ce2c7203))
 - **FIX**: :bug: HttpClient connects to incorrect endpoint. ([58dd870f](https://github.com/widgetbook/widgetbook/commit/58dd870f42ca7f5b27080ccea64705dbfbb2274c))
 - **FIX**: :bug: UseCaseParser contains hard-coded branch name. ([8acf8db4](https://github.com/widgetbook/widgetbook/commit/8acf8db41d9af5c206e92d41adb569bd3b366b61))
 - **FIX**: :bug: ambiguous warning for no generator themes. ([fbc56b54](https://github.com/widgetbook/widgetbook/commit/fbc56b547b021448cd72bca839e61f7fb34c20e3))
 - **FIX**: :bug: rename cli to widgetbook. ([3819094e](https://github.com/widgetbook/widgetbook/commit/3819094e43a1924677fd74a2ff34651a33b8f222))
 - **FEAT**: :sparkles: link to review. ([db2f239a](https://github.com/widgetbook/widgetbook/commit/db2f239ab2792199559de53f0d270cc991e91765))
 - **FEAT**: :sparkles: add `designLink` property. ([daad8e9c](https://github.com/widgetbook/widgetbook/commit/daad8e9cbcbdda94f2a6e985d20879e96e19d0b9))
 - **FEAT**: :sparkles: implement ci parser class to parse ci/cd runner information. ([fb95a76b](https://github.com/widgetbook/widgetbook/commit/fb95a76b467a1ecfcc410b3ac9b6cb7a4fdac0ad))
 - **FEAT**: comment link to review. ([c320a727](https://github.com/widgetbook/widgetbook/commit/c320a7270d6a70f9e706375db9d576997afec374))
 - **FEAT**: :sparkles: improve markdown on PR comments. ([0b598639](https://github.com/widgetbook/widgetbook/commit/0b598639d43ccf9957bd1baa8cd3064eb2124b24))
 - **FEAT**: :sparkles: comment link to Build in PR. ([9ea0ebf3](https://github.com/widgetbook/widgetbook/commit/9ea0ebf34b2b60f6b3b9cc19da8bc63d4765b333))
 - **FEAT**: :sparkles: changed branch and commit argument to optional. ([2c37580c](https://github.com/widgetbook/widgetbook/commit/2c37580cb0abbd2389ce3796388121a9317c0ac3))
 - **FEAT**: :bookmark: publish CLI to pub.dev. ([f40a4512](https://github.com/widgetbook/widgetbook/commit/f40a45120cbe401b2593fb2b32d67c630fc289df))
 - **DOCS**: :memo: add `pr` and `github-token` args. ([7f600037](https://github.com/widgetbook/widgetbook/commit/7f60003763f2ea966d27f1bebec66f7491fa9718))
 - **DOCS**: :bug: change relative links to global links. ([c0b5e408](https://github.com/widgetbook/widgetbook/commit/c0b5e40881f8946f5c76e82825e74971be8d0443))
 - **DOCS**: :memo: add documentation for CLI. ([2aeabef9](https://github.com/widgetbook/widgetbook/commit/2aeabef9f05b9d24fd46d0794fae0e7f16ac9ed7))

## 3.0.0-beta.17

- feat: add link to review in GitHub comment

## 3.0.0-beta.16

- fix: upload of locales, devices, themes and text scales

## 3.0.0-beta.15

- fix: `designLink` is not uploaded

## 3.0.0-beta.14
- feat: add upload of `designLink` property
- fix: CLI returns code `>0` when no review information is available

## 3.0.0-beta.13

- feat: add command for `publish`

## 2.0.3-beta.1

- fix(cli): `UseCaseParser` uses `ref` instead of `base` branch
- fix(cli): `HttpClient` connects to incorrect endpoint

## 2.0.2

- fix(cli): `UseCaseParser` contains hard-coded branch name

## 2.0.1

- feat: improve comment link markdown. 

## 2.0.0

- docs: add `pr` and `github-token` arguments
- feat: improve comment link markdown
- feat: comment link to Build in PR
- fix: ambiguous warning when no generator files are found
- docs: change relative links to global links.
- feat: change `path`, `branch`, `commit`, and `git-provider` arguments from mandatory to optional.
- fix: change name of executable from `widgetbook-cli` to `widgetbook`.
- Initial version.