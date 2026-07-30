import 'dart:convert';

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:platform/platform.dart';

import '../git/git.dart';
import '../utils/utils.dart';
import 'context.dart';

/// Matches the ref GitHub Actions sets on a pull request event,
/// e.g. `refs/pull/123/merge`.
final _githubPullRequestRef = RegExp(r'^refs/pull/(\d+)/');

class ContextManager {
  const ContextManager({
    this.platform = const LocalPlatform(),
    this.ciManager = const CiManager(),
    this.fileSystem = const LocalFileSystem(),
  });

  final Platform platform;
  final CiManager ciManager;
  final FileSystem fileSystem;

  /// Reads the pull request number and head commit of a GitHub Actions run.
  ///
  /// `GITHUB_SHA` is deliberately not used as the head: on a pull request
  /// event it points at the ephemeral merge commit, which never exists on the
  /// head branch. The real head only lives in the event payload.
  ({int? number, String? headSha}) _githubPullRequest() {
    final ref = platform.environment['GITHUB_REF'];
    final match = ref == null ? null : _githubPullRequestRef.firstMatch(ref);
    final number = match == null ? null : int.tryParse(match.group(1)!);

    final eventPath = platform.environment['GITHUB_EVENT_PATH'];
    if (eventPath == null) return (number: number, headSha: null);

    final file = fileSystem.file(eventPath);
    if (!file.existsSync()) return (number: number, headSha: null);

    try {
      final event = jsonDecode(file.readAsStringSync());
      if (event is! Map<String, dynamic>) {
        return (number: number, headSha: null);
      }

      final pullRequest = event['pull_request'];
      if (pullRequest is! Map<String, dynamic>) {
        return (number: number, headSha: null);
      }

      final head = pullRequest['head'];
      final headSha = head is Map<String, dynamic> ? head['sha'] : null;

      return (
        number: number ?? pullRequest['number'] as int?,
        headSha: headSha is String ? headSha : null,
      );
    } on FormatException {
      // A malformed event payload must not break unrelated commands that only
      // need the rest of the context.
      return (number: number, headSha: null);
    }
  }

  /// Returns the relevant [Context] for the current environment.
  /// The [Context] is based on the if the current environment is a CI provider
  /// or a local one.
  Future<Context> load(
    Repository? repository,
  ) async {
    if (ciManager.isAzure) {
      final sourceBranch = platform.environment['BUILD_SOURCEBRANCH'];
      final prSourceBranch =
          platform.environment['SYSTEM_PULLREQUEST_SOURCEBRANCH'];

      final isPr = sourceBranch?.contains('refs/pull/') ?? false;
      final branch = isPr ? prSourceBranch : sourceBranch;

      return Context(
        name: 'Azure',
        repository: repository,
        user: platform.environment['BUILD_SOURCEVERSIONAUTHOR'],
        project: platform.environment['BUILD_REPOSITORY_NAME'],
        providerBranch: branch != null ? Reference.nameOf(branch) : null,
      );
    }

    if (ciManager.isBitbucket) {
      return Context(
        name: 'Bitbucket',
        repository: repository,
        user: platform.environment['BITBUCKET_STEP_TRIGGERER_UUID'],
        project: platform.environment['BITBUCKET_REPO_FULL_NAME'],
      );
    }

    if (ciManager.isCodemagic) {
      return Context(
        name: 'Codemagic',
        repository: repository,
        user: 'Codemagic',
        project: platform.environment['CM_REPO_SLUG'],
        providerSha: platform.environment['CM_COMMIT'],
      );
    }

    if (ciManager.isGitHub) {
      final pullRequest = _githubPullRequest();

      return Context(
        name: 'GitHub',
        repository: repository,
        user: platform.environment['GITHUB_ACTOR'],
        project: platform.environment['GITHUB_REPOSITORY'],
        providerSha: platform.environment['GITHUB_SHA'],
        providerPrNumber: pullRequest.number,
        providerPrHeadSha: pullRequest.headSha,
      );
    }

    if (ciManager.isGitLab) {
      return Context(
        name: 'GitLab',
        repository: repository,
        user: platform.environment['GITLAB_USER_LOGIN'],
        project: platform.environment['CI_PROJECT_PATH'],
        providerBranch: platform.environment['CI_COMMIT_BRANCH'],
        providerSha: platform.environment['CI_COMMIT_SHA'],
      );
    }

    // For unknown CI providers and local environments
    return Context(
      name: ciManager.vendor?.name ?? 'Local',
      repository: repository,
      user: await repository?.user,
      project: repository?.name,
    );
  }
}
